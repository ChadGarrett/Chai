//
//  BaseDataProvider.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

enum DataProviderState {
    case started
    case stopped
}

protocol DataProviderStateDelegate: class {
    func providerDidUpdate(to state: DataProviderState)
}

protocol DataProviderUpdateDelegate: class {
    func providerDataDidUpdate() // TODO: Include the provider that was updated
}

class BaseDataProvider<F: BaseObject> {
    typealias QueryOptions = ProviderQueryOptions
    
    // MARK: Delegate
    
    internal weak var stateDelegate: DataProviderStateDelegate?
    
    internal weak var updateDelegate: DataProviderUpdateDelegate?
    
    // MARK: Properties
    
    internal var bindTarget: DataProviderBindTarget
    
    internal var limit: Int?
    
    private var token: NotificationToken?
    
    private var state: DataProviderState = .stopped {
        didSet { self.stateDidUpdate() }
    }
    
    internal var basePredicate: NSPredicate = NSPredicate(value: true) {
        didSet {
            if self.basePredicate != oldValue,
                self.token != nil {
                self.token?.invalidate()
                self.start()
                //self.scrollToTop()
            }
        }
    }
    
    internal var filter: NSPredicate = NSPredicate(value: true) {
        didSet {
            if self.filter != oldValue,
                self.token != nil {
                self.token?.invalidate()
                self.start()
                //self.scrollToTop()
            }
        }
    }
    
    internal var sort: [SortDescriptor] = [] {
        didSet {
            if self.sort != oldValue,
                self.token != nil {
                self.token?.invalidate()
                self.start()
                //self.scrollToTop()
            }
        }
    }
    
    // MARK: Setup
    
    init(bindTo target: DataProviderBindTarget, basePredicate: NSPredicate, filter: NSPredicate, sort: [SortDescriptor]) {
        self.bindTarget = target
        self.basePredicate = basePredicate
        self.filter = filter
        self.sort = sort
    }
    
    private typealias QueryAndRealm = (query: Results<F>, realm: Realm)
    
    private func queryAndRealm(options: QueryOptions = .default) -> QueryAndRealm {
        let realm = DBManager().database
        realm.refresh()
        let query = realm
            .objects(F.self)
            .filter(basePredicate)
            .filter(options.isFiltered ? self.filter : NSPredicate(value: true))
            .sorted(by: options.isSorted ? self.sort : [])
        return (query: query, realm: realm)
    }
    
    internal func query(_ options: QueryOptions = .default) -> Results<F> {
        return queryAndRealm(options: options).query
    }
    
    // MARK: Interface
    
    internal func start() {
        SwiftyBeaver.info("Starting data provider.")
        DispatchQueue.main.async { [weak self] in
            self?.token?.invalidate()
            self?.token = self?.query().observe { [weak self] (changes: RealmCollectionChange) in
                DispatchQueue.main.async {
                    switch changes {
                    case .initial:
                        self?.bindTarget.handleInitialUpdate()
                        self?.updateDelegate?.providerDataDidUpdate()
                        
                    case .update(_, let deletes, let inserts, let changes):
                        self?.bindTarget.handleUpdates(deletes: deletes, inserts: inserts, changes: changes, limit: self?.limit)
                        self?.updateDelegate?.providerDataDidUpdate()
                        
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
            }
            self?.state = .started
        }
    }
    
    internal func stop() {
        SwiftyBeaver.info("Stopping data provider.")
        token?.invalidate()
        self.state = .stopped
    }
    
    internal func object(at index: Int, refresh: Bool = false) -> F? {
        return item(at: index, refresh: refresh)
    }
    
    private func item(at index: Int, refresh: Bool = false) -> F? {
        //Can't assume index is always within range
        let (results, _) = self.queryAndRealm()
        guard index < results.count
            else { return nil }
        
        let item = results[index]
        return item
    }
    
    // MARK: Helpers
    
    private func stateDidUpdate() {
        self.stateDelegate?.providerDidUpdate(to: self.state)
    }
}
