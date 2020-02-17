//
//  DebitOrderController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver

/// Controller to view and manage debit orders
final class DebitOrderController: BaseViewController {
    
    // MARK: Properties
    
    private var debitOrderView: DebitOrderView
    
    // MARK: Setup
    
    override init() {
        self.debitOrderView = DebitOrderView()
        super.init()
        
        self.title = R.string.localizable.title_debit_orders()
        
        self.setupView()
        self.setupTableDataDependencies()
    }
    
    deinit {
        self.dataProvider.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    private func setupView() {
        self.navigationItem.rightBarButtonItems = [self.btnAdd, self.btnRefresh] //.setRightBarButton(self.btnRefresh, animated: true)
        
        self.view.addSubview(self.debitOrderView)
        self.debitOrderView.autoPinEdgesToSuperviewSafeArea()
    }
    
    private func setupTableDataDependencies() {
        self.debitOrderView.tableView.dataSource = self
        self.debitOrderView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataProvider.start()
    }
    
    // MARK: Data
    
    private lazy var dataProvider: BaseDataProvider<DebitOrderObject> = {
        let provider = BaseDataProvider<DebitOrderObject>(
            bindTo: .tableView(self.debitOrderView.tableView),
            basePredicate: NSPredicate(value: true),
            filter: NSPredicate(value: true),
            sort: [SortDescriptor(keyPath: "amount", ascending: false)])
        provider.updateDelegate = self
        return provider
    }()
    
    private func fetchData() {
        DebitOrderDataService.fetchDebitOrders { (result) in
            switch result {
            case .failure:
                BannerService.shared.showBanner(title: "Unable to fetch debit orders.", style: .danger)
                
            case .success:
                BannerService.shared.showStatusBarBanner(title: "Synced debit orders", style: .success)
            }
        }
    }
    
    // MARK: Filters
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search"
        controller.delegate = self
        return controller
    }()
    
    private var currentSearchText: String = "" {
        didSet {
            self.filterAndSearchDidUpdate()
        }
    }
    
    private var currentSearchPredicate: NSPredicate {
        get {
            if self.currentSearchText.isEmpty {
                return NSPredicate(value: true)
            } else {
                return NSPredicate(format: "title CONTAINS(%@)", self.currentSearchText)
            }
        }
    }
    
    private func filterAndSearchDidUpdate() {
        self.dataProvider.filter = self.currentSearchPredicate
    }
    
    private lazy var btnRefresh: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(onRefresh))
        return button
    }()
    
    private lazy var btnAdd: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onAdd))
        return button
    }()
    
    @objc private func onRefresh() {
        SwiftyBeaver.info("Manually refreshing data.")
        self.fetchData()
    }
    
    @objc private func onAdd() {
        SwiftyBeaver.debug("Tapped on add")
        
        let controller = DebitOrderEditController(mode: .create)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension DebitOrderController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.query().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let debitOrder = self.dataProvider.object(at: indexPath.row)
            else { return self.getBlankTableCell(tableView, for: indexPath) }
        
        return self.getDebitOrderCell(tableView, for: indexPath, with: debitOrder)
    }
    
    private func getBlankTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
    
    private func getDebitOrderCell(_ tableView: UITableView, for indexPath: IndexPath, with debitOrder: DebitOrderObject) -> UITableViewCell {
        let cell: DebitOrderCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(debitOrder: debitOrder)
        return cell
    }
}

extension DebitOrderController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let debitOrder = self.dataProvider.object(at: indexPath.row)
            else { return }
        
        SwiftyBeaver.debug("Tapped on \(debitOrder)")
        
        let controller = DebitOrderEditController(mode: .edit(debitOrder))
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension DebitOrderController: DataProviderUpdateDelegate {
    func providerDataDidUpdate<F>(_ provider: BaseDataProvider<F>) where F : BaseObject {
        if provider === self.dataProvider {
            SwiftyBeaver.info("Debit order data did update")
            
            let total: Double = self.dataProvider.query().reduce(0) { (count, item) -> Double in return count + item.amount }
            self.debitOrderView.vwSummary.updateTotal(to: total)
        }
    }
}

extension DebitOrderController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.currentSearchText = searchController.searchBar.text ?? ""
    }
}

extension DebitOrderController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
