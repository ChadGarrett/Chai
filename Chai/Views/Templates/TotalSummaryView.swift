//
//  TotalSummaryView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

/// A card view to display a total monetary figure
final class TotalSummaryView: BaseView {
    
    // MARK: Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwCard)
        self.vwCard.autoPinEdgesToSuperviewEdges()
        
        self.vwCard.addSubview(self.lblTotal)
        self.lblTotal.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(insetHorizontal: Style.padding.s, insetVertical: Style.padding.m))
    }
    
    // MARK: Interface
    
    internal func updateTotal(to amount: Double) {
        let totalString: String = NumberHelper.currencyFormatter.string(from: amount) ?? ""
        
        let out: NSMutableAttributedString = NSMutableAttributedString()
        out.append(NSAttributedString(string: "Total \(totalString)", attributes: Style.heading_1))
        self.lblTotal.attributedText = out
    }
    
    // MARK: Subviews
    
    private lazy var vwCard: AppCardView = AppCardView()
    
    private lazy var lblTotal: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
}
