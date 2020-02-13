//
//  SavingsCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class SavingsCell: BaseTableViewCell {
    
    // MARK: Setup
    
    override func setupCell() {
        super.setupCell()
        
        self.contentView.addSubview(self.vwCard)
        self.vwCard.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(inset: Style.padding.s))
        
        self.vwCard.addSubview(self.lblHeading)
        self.vwCard.addSubview(self.lblAmount)
        self.vwCard.addSubview(self.lblDescription)
        self.vwCard.addSubview(self.lblLastUpdated)
        
        self.lblHeading.autoPinEdges(toSuperviewEdges: [.top, .left], withInset: Style.padding.s)
        
        self.lblAmount.autoPinEdges(toSuperviewEdges: [.top, .right], withInset: Style.padding.s)
        
        self.lblDescription.autoPinEdge(.top, to: .bottom, of: self.lblHeading, withOffset: Style.padding.xs)
        self.lblDescription.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Style.padding.s)
        
        self.lblLastUpdated.autoPinEdge(.top, to: .bottom, of: self.lblDescription, withOffset: Style.padding.xxs)
        self.lblLastUpdated.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom], withInset: Style.padding.s)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.lblHeading.attributedText = nil
        self.lblAmount.attributedText = nil
        self.lblDescription.attributedText = nil
        self.lblLastUpdated.attributedText = nil
    }
    
    // MARK: Interface
    
    internal func prepareForDisplay(saving: Saving) {
        self.prepareHeading(text: saving.title)
        self.prepareAmount(amount: saving.amount)
        self.prepareDescription(text: saving.descriptionAbout)
        self.prepareLastUpdated(text: saving.lastUpdated)
        self.prepareBackgroundColor(color: saving.colorHexCode)
    }
    
    private func prepareHeading(text: String) {
        self.lblHeading.attributedText = NSAttributedString(
            string: text,
            attributes: Style.heading_1)
    }
    
    private func prepareAmount(amount: Double) {
        let text: String = NumberHelper.currencyFormatter.string(from: amount) ?? ""
        self.lblAmount.attributedText = NSAttributedString(
            string: text,
            attributes: Style.heading_1_right)
    }
    
    private func prepareDescription(text: String) {
        self.lblDescription.attributedText = NSAttributedString(
            string: text,
            attributes: Style.body)
    }
    
    private func prepareLastUpdated(text: String) {
        self.lblLastUpdated.attributedText = NSAttributedString(
            string: R.string.localizable.savings_last_updated(text),
            attributes: Style.body)
    }
    
    private func prepareBackgroundColor(color: String) {
        self.vwCard.backgroundColor = UIColor(hex: color)
    }
    
    // MARK: Subviews
    
    private lazy var vwCard: AppCardView = AppCardView()
    
    private lazy var lblHeading: UILabel = UILabel()
    
    private lazy var lblAmount: UILabel = UILabel()
    
    private lazy var lblDescription: UILabel = UILabel()
    
    private lazy var lblLastUpdated: UILabel = UILabel()
}
