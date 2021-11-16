//
//  PrepaidElectricityCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import UIKit

final class PrepaidElectricityCell: BaseTableViewCell {

    // MARK: Setup

    override func setupCell() {
        super.setupCell()

        self.contentView.addSubview(self.lblDateBought)
        self.contentView.addSubview(self.lblBuyer)
        self.contentView.addSubview(self.lblRandAmount)
        self.contentView.addSubview(self.lblCharges)
        self.contentView.addSubview(self.lblKwh)

        self.lblDateBought.autoPinEdges(toSuperviewEdges: [.top, .left], withInset: Style.padding.s)

        self.lblBuyer.autoPinEdges(toSuperviewEdges: [.top, .right], withInset: Style.padding.s)
        self.lblBuyer.autoPinEdge(.left, to: .right, of: self.lblDateBought, withOffset: Style.padding.m)

        self.lblRandAmount.autoPinEdge(.top, to: .bottom, of: self.lblDateBought, withOffset: Style.padding.s)
        self.lblRandAmount.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Style.padding.s)

        self.lblCharges.autoPinEdge(.top, to: .bottom, of: self.lblRandAmount, withOffset: Style.padding.s)
        self.lblCharges.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Style.padding.s)

        self.lblKwh.autoPinEdge(.top, to: .bottom, of: self.lblCharges, withOffset: Style.padding.s)
        self.lblKwh.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom], withInset: Style.padding.s)
    }

    internal func prepareForDisplay(prepaidElectricity: PrepaidElectricityObject) {
        self.setupDateBought(text: prepaidElectricity.dateBought)
        self.setupBuyer(text: prepaidElectricity.buyer)
        self.setupDetails(randAmount: prepaidElectricity.randAmount, charges: prepaidElectricity.charges, amountBought: prepaidElectricity.amountBought)
    }

    private func setupDateBought(text: String) {
        self.lblDateBought.attributedText = NSAttributedString(
        string: text,
        attributes: Style.heading_1)
    }

    private func setupBuyer(text: String) {
        if let buyer = text.nonEmpty {
            self.lblBuyer.attributedText = NSAttributedString(
                string: buyer,
                attributes: Style.heading_1_right)
        }
    }

    private func setupDetails(randAmount: Double, charges: Double, amountBought: Double) {
        self.lblRandAmount.attributedText = NSAttributedString(
            string: NumberHelper.currencyFormatter.string(from: randAmount) ?? "",
            attributes: Style.body)

        self.lblCharges.attributedText = NSAttributedString(
            string: NumberHelper.currencyFormatter.string(from: charges) ?? "",
            attributes: Style.body)

        self.lblKwh.attributedText = NSAttributedString(
            string: "\(amountBought)Kwh",
            attributes: Style.body)
    }

    // MARK: Subviews

    private lazy var lblDateBought: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var lblBuyer: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var lblRandAmount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var lblCharges: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var lblKwh: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
}
