//
//  PrepaidElectricityController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

final class PrepaidElectricityController: AppViewController {
    
    // MARK: Properties
    
    private let prepaidElectricityView: PrepaidElectricityView
    
    private var token: NotificationToken?
    
    // MARK: Setup
    
    override init() {
        self.prepaidElectricityView = PrepaidElectricityView()
        super.init()
        self.setupLayout()
        self.setupTableDataDependencies()
        self.setupBinding()
    }
    
    deinit {
        self.token?.invalidate()
        self.token = nil
    }
    
    private func setupLayout() {
        self.navigationItem.setRightBarButton(self.btnRefresh, animated: true)
        self.view.addSubview(self.prepaidElectricityView)
        self.prepaidElectricityView.autoPinEdgesToSuperviewEdges()
    }
    
    private lazy var btnRefresh: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(onRefresh))
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    // MARK: Data
    
    private func setupBinding() {
        if self.token == nil {
            self.token = DebitOrderContext.shared.bind(to: self.prepaidElectricityView.tableView)
        }
    }
    
    private func setupTableDataDependencies() {
        self.prepaidElectricityView.tableView.dataSource = self
        self.prepaidElectricityView.tableView.delegate = self
    }
    
    private func fetchData() {
        PrepaidElectricityDataService.fetchPrepaidElectricity()
        self.prepaidElectricityView.tableView.reloadData()
    }
    
    // MARK: Actions
    
    @objc private func onRefresh() {
        SwiftyBeaver.info("Manually refreshing data.")
        self.fetchData()
    }
}

extension PrepaidElectricityController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PrepaidElectricityContext.shared.getElectricity().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let electricity = PrepaidElectricityContext.shared.getElectricity(at: indexPath.row)
            else { return self.getBlankTableCell(tableView, for: indexPath)}
        
        return self.getElectricityCell(tableView, with: electricity, for: indexPath)
    }
    
    private func getBlankTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
    
    private func getElectricityCell(_ tableView: UITableView, with electricity: PrepaidElectricity, for indexPath: IndexPath) -> UITableViewCell {
        let cell: PrepaidElectricityCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(prepaidElectricity: electricity)
        return cell
    }
}

extension PrepaidElectricityController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let electricity = PrepaidElectricityContext.shared.getElectricity(at: indexPath.row)
            else { return }
        
        SwiftyBeaver.verbose("Selected: \(electricity)")
    }
}
