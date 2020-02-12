//
//  DebitOrderSummaryView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class DebitOrderSummaryView: BaseView {
    
    // MARK: Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwCard)
        self.vwCard.autoPinEdgesToSuperviewEdges()
        
        self.vwCard.addSubview(self.lblTotalDebits)
        self.lblTotalDebits.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(insetHorizontal: Style.padding.s, insetVertical: Style.padding.m))
    }
    
    // MARK: Interface
    
    internal func updateData() {
        let total: Double = DebitOrderContext.shared.getDebitOrders().reduce(0) { (count, debitOrder) -> Double in return count + debitOrder.amount }
        let totalString: String = NumberHelper.currencyFormatter.string(from: total) ?? ""
        
        let out: NSMutableAttributedString = NSMutableAttributedString()
        out.append(NSAttributedString(string: "Total \(totalString)", attributes: Style.heading_1))
        self.lblTotalDebits.attributedText = out
    }
    
    // MARK: Subviews
    
    private lazy var vwCard: AppCardView = AppCardView()
    
    private lazy var lblTotalDebits: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
}
