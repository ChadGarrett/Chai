//
//  TotalSummaryView.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

protocol TotalSummaryViewDelegate: class {
    func onSort()
}

/// A card view to display a total monetary figure
final class TotalSummaryView: BaseView {
    
    // MARK: Delegate
    
    internal weak var totalSummaryDelegate: TotalSummaryViewDelegate?
    
    // MARK: Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwCard)
        self.vwCard.autoPinEdgesToSuperviewEdges()
        
        self.vwCard.addSubview(self.btnSort)
        self.vwCard.addSubview(self.lblTotal)
        
        self.btnSort.autoPinEdges(toSuperviewEdges: [.right], withInset: Style.padding.s)
        
        self.lblTotal.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblTotal.autoPinEdges(toSuperviewEdges: [.top, .bottom], withInset: Style.padding.m)
        self.lblTotal.autoPinEdge(.right, to: .left, of: self.btnSort, withOffset: -Style.padding.m)
        
        self.btnSort.autoAlignAxis(.horizontal, toSameAxisOf: self.lblTotal)
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

    private lazy var btnSort: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
        }
        button.addTarget(self, action: #selector(onSort), for: .touchUpInside)
        return button
    }()
    
    @objc private func onSort() {
        self.totalSummaryDelegate?.onSort()
    }
}
