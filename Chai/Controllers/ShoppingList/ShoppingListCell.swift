//
//  ShoppingListCell.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import Reusable
import UIKit

final class ShoppingListCell: UITableViewCell, Reusable {
    
    // Data
    private var item: ShoppingItem?
    
    // Delegate
    
    internal weak var delegate: ShoppingListDelegate?
    
    // UI
    
    private lazy var lblItem: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var switchBought: UISwitch = {
        let switchBought = UISwitch()
        switchBought.isOn = false
        switchBought.addTarget(self, action: #selector(onChange), for: .valueChanged)
        return switchBought
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupSubviews()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(self.lblItem)
        self.contentView.addSubview(self.switchBought)
    }
    
    private func setupLayout() {
        self.lblItem.autoPinEdgesToSuperviewEdges(with:
            UIEdgeInsets(top: Style.padding.xs, left: Style.padding.xs, bottom: Style.padding.xs, right: Style.padding.xs), excludingEdge: .right)
        self.switchBought.autoPinEdgesToSuperviewEdges(with:
            UIEdgeInsets(top: Style.padding.s, left: 0, bottom: Style.padding.s, right: Style.padding.s), excludingEdge: .left)
    }
    
    internal func prepareForDisplay(item: ShoppingItem) {
        self.item = item
        
        self.lblItem.attributedText = NSAttributedString(string: item.name)
        self.switchBought.isOn = item.isBought
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.item = nil
        self.lblItem.attributedText = nil
        self.switchBought.isOn = false
    }
}

// Actions
extension ShoppingListCell {
    @objc private func onChange() {
        guard let item = item else { return }
        self.delegate?.onUpdateItemStatus(item: item)
    }
}
