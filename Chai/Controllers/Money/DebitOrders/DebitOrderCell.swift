//
//  DebitOrderCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Reusable

final class DebitOrderCell: BaseTableViewCell {
    
    // MARK: Setup
    
    override func setupCell() {
        super.setupCell()
        
        self.contentView.addSubview(self.lblName)
        self.contentView.addSubview(self.lblAmount)
        
        self.lblAmount.autoPinEdges(toSuperviewEdges: [.top, .right], withInset: Style.padding.s)
        
        self.lblName.autoPinEdges(toSuperviewEdges: [.top, .left], withInset: Style.padding.s)
        self.lblName.autoPinEdge(.right, to: .left, of: self.lblAmount, withOffset: -Style.padding.m, relation: .lessThanOrEqual)
        self.lblName.autoPinEdge(toSuperviewEdge: .bottom, withInset: Style.padding.s, relation: .greaterThanOrEqual)
    }
    
    internal func prepareForDisplay(debitOrder: DebitOrder) {
        self.lblName.attributedText = NSAttributedString(
            string: debitOrder.title,
            attributes: Style.heading_2)
        
        if let amount: String = NumberHelper.currencyFormatter.string(from: debitOrder.amount) {
            self.lblAmount.attributedText = NSAttributedString(
                string: amount,
                attributes: Style.body)
        }
    }
    
    // MARK: Subviews
    
    private lazy var lblName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var lblAmount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
}
