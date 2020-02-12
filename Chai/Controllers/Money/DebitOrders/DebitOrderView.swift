//
//  DebitOrderView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

protocol DebitOrderViewDelegate: class {
    
}

final class DebitOrderView: AppView {
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwSummary)
        self.addSubview(self.tableView)
        
        self.vwSummary.autoPinEdge(toSuperviewSafeArea: .top, withInset: Style.padding.m)
        self.vwSummary.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Style.padding.s)
        self.tableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    // MARK: Subviews
    
    private lazy var vwSummary: AppCardView = {
        let view = AppCardView()
        
        return view
    }()
    
    /// List showing all the debit orders
    internal lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(cellType: DebitOrderCell.self)
        tableView.register(cellType: BlankTableCell.self)
        return tableView
    }()
}
