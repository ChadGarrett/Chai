//
//  DebitOrderView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class DebitOrderView: AppView {
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.tableView)
        
        self.tableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    // MARK: Subviews
    
    /// List showing all the debit orders
    internal lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: DebitOrderCell.self)
        tableView.register(cellType: BlankTableCell.self)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}
