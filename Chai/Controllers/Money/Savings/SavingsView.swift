//
//  SavingsView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class SavingsView: BaseView {
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.tableView)
        self.tableView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: Subviews
    
    internal lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(cellType: SavingsCell.self)
        tableView.register(cellType: BlankTableCell.self)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
}
