//
//  DebitOrderCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Reusable

final class DebitOrderCell: BaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    override var isSelected: Bool {
        didSet {
            self.isSelectedDidUpdate()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func prepareForDisplay(debitOrder: DebitOrderObject) {
        self.textLabel?.text = debitOrder.title

        if let amount: String = NumberHelper.currencyFormatter.string(from: debitOrder.amount) {
            self.detailTextLabel?.text = amount
        }
    }
}

extension DebitOrderCell {
    private final func isSelectedDidUpdate() {
        if self.isSelected {

        } else {

        }
    }
}
