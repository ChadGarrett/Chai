//
//  DebitOrderViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver

/// Controller to view and manage debit orders
final class DebitOrderViewController: BaseViewController {
    
    // MARK: Properties
    
    private var debitOrderView: DebitOrderView
    
    private var token: NotificationToken?
    
    // MARK: Setup
    
    override init() {
        self.debitOrderView = DebitOrderView()
        super.init()
        
        self.title = R.string.localizable.title_debit_orders()
        
        self.setupView()
        self.setupTableDataDependencies()
        self.setupBinding()
    }
    
    deinit {
        self.token?.invalidate()
        self.token = nil
    }
    
    private func setupView() {
        self.navigationItem.setRightBarButton(self.btnRefresh, animated: true)
        
        self.view.addSubview(self.debitOrderView)
        self.debitOrderView.autoPinEdgesToSuperviewEdges()
    }
    
    private func setupTableDataDependencies() {
        self.debitOrderView.tableView.dataSource = self
        self.debitOrderView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    // MARK: Data
    
    private func setupBinding() {
        if self.token == nil {
            self.token = DebitOrderContext.shared.bind(to: self.debitOrderView.tableView)
        }
    }
    
    private func fetchData() {
        DebitOrderDataService.fetchDebitOrders()
    }
    
    private lazy var btnRefresh: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(onRefresh))
        return button
    }()
    
    @objc private func onRefresh() {
        SwiftyBeaver.info("Manually refreshing data.")
        self.debitOrderView.vwSummary.updateData()
        self.fetchData()
    }
}

extension DebitOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DebitOrderContext.shared.getDebitOrders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let debitOrder = DebitOrderContext.shared.getDebitOrder(at: indexPath.row)
            else { return self.getBlankTableCell(tableView, for: indexPath) }
        
        return self.getDebitOrderCell(tableView, for: indexPath, with: debitOrder)
    }
    
    private func getBlankTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
    
    private func getDebitOrderCell(_ tableView: UITableView, for indexPath: IndexPath, with debitOrder: DebitOrder) -> UITableViewCell {
        let cell: DebitOrderCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(debitOrder: debitOrder)
        return cell
    }
}

extension DebitOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let debitOrder = DebitOrderContext.shared.getDebitOrder(at: indexPath.row)
            else { return }
        
        SwiftyBeaver.debug("Tapped on \(debitOrder)")
    }
}
