//
//  AttentionView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

final class AttentionView: AppView {
    
    // Delegate
    
    internal weak var delegate: AttentionViewDelegate?
    
    // Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.colActions)
        self.addSubview(self.tblHistory)
        
        self.colActions.autoPinEdge(toSuperviewEdge: .top)
        self.colActions.autoPinEdge(toSuperviewEdge: .left)
        self.colActions.autoPinEdge(toSuperviewEdge: .right)
        
        self.tblHistory.autoPinEdge(.top, to: .bottom, of: self.colActions)
        self.tblHistory.autoPinEdge(toSuperviewEdge: .left)
        self.tblHistory.autoPinEdge(toSuperviewEdge: .right)
        self.tblHistory.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    // Subviews
    
    private lazy var colActions: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        // TODO: Datasource
        // TODO: Delegate
        return collectionView
    }()
    
    private lazy var tblHistory: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        // TODO: Datasource
        // TODO: Delegate
        return tableView
    }()
    
}
