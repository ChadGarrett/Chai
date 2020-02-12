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
        
        self.addSubview(self.vwSummary)
        self.addSubview(self.tableView)
        
        self.vwSummary.autoPinEdge(toSuperviewSafeArea: .top, withInset: Style.padding.s)
        self.vwSummary.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Style.padding.s)
        
        self.tableView.autoPinEdge(.top, to: .bottom, of: self.vwSummary, withOffset: Style.padding.s)
        self.tableView.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom])
    }
    
    // MARK: Subviews
    
    internal lazy var vwSummary: DebitOrderSummaryView = DebitOrderSummaryView()
    
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
