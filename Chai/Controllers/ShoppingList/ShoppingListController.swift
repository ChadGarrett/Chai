//
//  ShoppingListController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol ShoppingListDelegate: class {
    func onUpdateItemStatus(item: ShoppingItem)
    func onDeleteItem(item: ShoppingItem)
}

class ShoppingListController: UIViewController {
    
    private var items: [ShoppingItem] = [
        ShoppingItem(name: "Cheese"),
        ShoppingItem(name: "Milk"),
        ShoppingItem(name: "Eggs"),
        ShoppingItem(name: "Toilet paper", isBought: true)
        ] {
        didSet { shoppingListView.data = items }
    }
    
    // View
    
    private lazy var shoppingListView: ShoppingListView = {
        let shoppingListView = ShoppingListView()
        shoppingListView.data = items
        shoppingListView.delegate = self
        return shoppingListView
    }()
    
    private lazy var btnEdit: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Add"
        button.target = self
        button.action = #selector(onAdd)
        return button
    }()
    
    // Setup
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shopping List"
        
        self.setupSubviews()
        self.setupLayout()
    }
    
    private func setupSubviews() {
        self.view.addSubview(self.shoppingListView)
        
        self.navigationItem.rightBarButtonItem = self.btnEdit
    }
    
    private func setupLayout() {
        self.shoppingListView.autoPinEdgesToSuperviewEdges()
    }
}

// Actions
extension ShoppingListController {
    @objc private func onAdd() {
        let alert = UIAlertController(title: "Add new item", message: "Add an item to the shopping list", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            guard let newItemName = alert?.textFields?.first?.text
                else { return }
            self.addNewItem(name: newItemName)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewItem(name: String) {
        self.items.append(ShoppingItem(name: name))
    }
}

extension ShoppingListController: ShoppingListDelegate {
    func onDeleteItem(item: ShoppingItem) {
        self.items.removeAll(where: {$0 == item})
    }
    
    func onUpdateItemStatus(item: ShoppingItem) {
        item.updateBoughtStatus()
    }
}
