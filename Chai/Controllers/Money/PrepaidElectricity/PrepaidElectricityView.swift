//
//  PrepaidElectricityView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class PrepaidElectricityView: BaseView {
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.tableView)
        
        self.tableView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: Subviews
    
    /// List showing all the debit orders
    internal lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: PrepaidElectricityCell.self)
        tableView.register(cellType: BlankTableCell.self)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
