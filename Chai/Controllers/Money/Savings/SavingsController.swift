//
//  SavingsController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver

final class SavingsController: BaseViewController {
    
    // MARK: Properties
    
    private lazy var vwSavings: SavingsView = SavingsView()
    
    // MARK: Setup
    
    override init() {
        super.init()
        self.title = R.string.localizable.title_savings()
        self.setupLayout()
        self.bindTableDelegateAndDataSource()
    }
    
    deinit {
        self.dataProvider.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataProvider.start()
        self.fetchData()
    }
    
    private func setupLayout() {
        self.navigationItem.setRightBarButton(self.btnRefresh, animated: true)
        self.view.addSubview(self.vwSavings)
        self.vwSavings.autoPinEdgesToSuperviewEdges()
    }
    
    private func bindTableDelegateAndDataSource() {
        self.vwSavings.tableView.dataSource = self
        self.vwSavings.tableView.delegate = self
    }
    
    private lazy var btnRefresh: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(onRefresh))
        return button
    }()
    
    // MARK: Data
    
    private lazy var dataProvider: BaseDataProvider<Saving> = {
        let provider = BaseDataProvider<Saving>(
            bindTo: .tableView(self.vwSavings.tableView),
            basePredicate: NSPredicate(value: true),
            filter: NSPredicate(value: true),
            sort: [SortDescriptor(keyPath: "amount", ascending: false)])
        provider.updateDelegate = self
        return provider
    }()
    
    private func fetchData() {
        SavingsAPIService.fetchSavings() { (result) in
            switch result {
            case .failure:
                BannerService.shared.showBanner(title: "Unable to fetch all savings", style: .danger)

            case .success:
                BannerService.shared.showStatusBarBanner(title: "Synced savings", style: .success)
            }        
        }
    }
    
    // MARK: Actions
    
    @objc private func onRefresh() {
        self.fetchData()
    }
}

extension SavingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.query().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let saving = self.dataProvider.object(at: indexPath.row)
            else { return self.getEmptyTableCell(tableView, for: indexPath) }
        
        return self.getSavingsCell(tableView, for: indexPath, saving: saving)
    }
    
    private func getEmptyTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
    
    private func getSavingsCell(_ tableView: UITableView, for indexPath: IndexPath, saving: Saving) -> UITableViewCell {
        let cell: SavingsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(saving: saving)
        return cell
    }
}

extension SavingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let saving = self.dataProvider.object(at: indexPath.row)
            else { return }
        
        SwiftyBeaver.verbose("Tapped on \(saving)")
    }
}

extension SavingsController: DataProviderUpdateDelegate {
    func providerDataDidUpdate<F>(_ provider: BaseDataProvider<F>) where F : BaseObject {
        if provider === self.dataProvider {
            SwiftyBeaver.info("Savings data did update.")
            
            let total: Double = self.dataProvider.query().reduce(0) { (count, item) -> Double in return count + item.amount }
            self.vwSavings.vwSummary.updateTotal(to: total)
        }
    }
}
