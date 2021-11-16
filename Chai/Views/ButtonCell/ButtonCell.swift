//
//  ButtonCell.swift
//  Chai
//
//  Created by Chad Garrett on 2020/07/08.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Reusable

protocol ButtonCellDelegate: AnyObject {
    func onAction(at indexPath: IndexPath)
}

final class ButtonCell: BaseTableViewCell {

    internal weak var delegate: ButtonCellDelegate?

    // MARK: Setup

    override func setupCell() {
        self.contentView.addSubview(self.btnAction)
        self.btnAction.autoPinEdgesToSuperviewEdges(with: .init(insetHorizontal: Style.padding.s, insetVertical: Style.padding.xs))
    }

    internal func prepareForDisplay(buttonText: String) {
        self.btnAction.setTitle(buttonText, for: .normal)
    }

    // MARK: Subviews

    private lazy var btnAction: CancelButton = {
        let button = CancelButton()
        button.addTarget(self, action: #selector(onAction), for: .touchUpInside)
        return button
    }()
}

// MARK: Actions
extension ButtonCell {
    @objc private func onAction() {
        guard let indexPath: IndexPath = self.getIndexPath()
            else { return }

        self.delegate?.onAction(at: indexPath)
    }
}
