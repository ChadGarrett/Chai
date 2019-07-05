//
//  ShoppingListView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit

final class ShoppingListView: AppView {
    
    // Data
    internal var data: [ShoppingItem] = [] {
        didSet { self.dataDidUpdate() }
    }
    
    // Delegates
    
    internal weak var delegate: ShoppingListDelegate?
    
    // Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: ShoppingListCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(self.tableView)
    }
    
    private func setupLayout() {
        self.tableView.autoPinEdge(toSuperviewSafeArea: .top)
        self.tableView.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
    }
    
    private func dataDidUpdate() {
        self.tableView.reloadData()
    }
    
    /// Fetches an item given its IndexPath, determines which list it is in and returns the item if found
    /// - Parameter indexPath: The IndexPath of the item you would like to find
    /// - Returns: Optionally returns a ShoppingItem if it can be found
    private func getitem(at indexPath: IndexPath) -> ShoppingItem? {
        guard let section = Sections(rawValue: indexPath.section)
            else { return nil }
        
        switch section {
        case .buy:
            return self.data.filter({ $0.isBought == false}).item(at: indexPath.row)
            
        case .bought:
            return self.data.filter({ $0.isBought == true }).item(at: indexPath.row)
        }
    }
}

extension ShoppingListView: UITableViewDelegate {
    enum Sections: Int, CaseIterable {
        case buy = 0
        case bought
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO?
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
            // Update data source when user taps action
            guard let item = self.getitem(at: indexPath) else {
                completionHandler(false)
                return
            }
            
            self.delegate?.onDeleteItem(item: item)
            completionHandler(true)
        })
        let swipeConfig = UISwipeActionsConfiguration(actions: [action])
        return swipeConfig
    }
}

extension ShoppingListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section)
            else { return 0 }
        
        switch section {
        case .buy:
            return data.filter({ $0.isBought == false }).count
            
        case .bought:
            return data.filter({$0.isBought == true}).count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Sections(rawValue: section)
            else { return nil }
        
        switch section {
        case .buy: return "Need to buy"
        case .bought: return "Recently bought"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else {
            return self.getBlankTableCell()
        }
        
        let cell: ShoppingListCell = self.tableView.dequeueReusableCell(for: indexPath, cellType: ShoppingListCell.self)
        
        switch section {
        case .buy:
            guard let item = data.filter({ $0.isBought == false}).item(at: indexPath.row) else {
                return self.getBlankTableCell()
            }
            cell.prepareForDisplay(item: item)
            
        case .bought:
            guard let item = data.filter({ $0.isBought == true}).item(at: indexPath.row) else {
                return self.getBlankTableCell()
            }
            cell.prepareForDisplay(item: item)
            
        }
        
        cell.delegate = delegate
        return cell
    }
    
    /// Returns an empty tableview cell, for when no data is available to dequeue a real cell
    private func getBlankTableCell() -> UITableViewCell {
        return UITableViewCell()
    }
}
