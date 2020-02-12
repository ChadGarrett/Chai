//
//  PrepaidElectricityController.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

final class PrepaidElectricityController: BaseViewController {
    
    // MARK: Properties
    
    private let prepaidElectricityView: PrepaidElectricityView
    
    // MARK: Setup
    
    override init() {
        self.prepaidElectricityView = PrepaidElectricityView()
        super.init()
        self.setupLayout()
        self.setupTableDataDependencies()
    }
    
    deinit {
        self.dataProvider.stop()
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
        self.dataProvider.start()
    }
    
    // MARK: Data
    
    private lazy var dataProvider: BaseDataProvider<PrepaidElectricity> = {
        return BaseDataProvider<PrepaidElectricity>(
            bindTo: .tableView(self.prepaidElectricityView.tableView),
            basePredicate: NSPredicate(value: true),
            filter: NSPredicate(value: true),
            sort: [])
    }()
    
    private func setupTableDataDependencies() {
        self.prepaidElectricityView.tableView.dataSource = self
        self.prepaidElectricityView.tableView.delegate = self
    }
    
    private func fetchData() {
        PrepaidElectricityDataService.fetchPrepaidElectricity()
    }
    
    // MARK: Actions
    
    @objc private func onRefresh() {
        SwiftyBeaver.info("Manually refreshing data.")
        self.fetchData()
    }
}

extension PrepaidElectricityController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.query().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let electricity = self.dataProvider.object(at: indexPath.row)
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
        guard let electricity = self.dataProvider.object(at: indexPath.row)
            else { return }
        
        SwiftyBeaver.verbose("Selected: \(electricity)")
    }
}
