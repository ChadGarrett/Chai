//
//  AcceptCancelButtonView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/05.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

protocol AcceptCancelButtonDelegate: AnyObject {
    func onAcceptButton()
    func onCancelButton()
}

/// A side by side Accept and Cancel button
final class AcceptCancelButtonView: BaseView {

    // Delegate

    internal weak var delegate: AcceptCancelButtonDelegate?

    override func setupView() {
        self.addSubview(self.btnConfirm)
        self.addSubview(self.btnCancel)

        self.btnConfirm.autoPinEdge(toSuperviewEdge: .top)
        self.btnConfirm.autoPinEdge(toSuperviewMargin: .left)
        self.btnConfirm.autoPinEdge(toSuperviewMargin: .bottom)

        self.btnCancel.autoPinEdge(toSuperviewEdge: .top)
        self.btnCancel.autoPinEdge(.left, to: .right, of: self.btnConfirm, withOffset: Style.padding.s)
        self.btnCancel.autoPinEdge(toSuperviewMargin: .right)
        self.btnCancel.autoPinEdge(toSuperviewMargin: .bottom)
    }

    // Subviews

    private lazy var btnConfirm: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle(R.string.localizable.button_confirm(), for: .normal)
        button.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        return button
    }()

    private lazy var btnCancel: CancelButton = {
        let button = CancelButton()
        button.setTitle(R.string.localizable.button_cancel(), for: .normal)
        button.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        return button
    }()

    // Actions

    @objc private func onConfirm() {
        self.delegate?.onAcceptButton()
    }

    @objc private func onCancel() {
        self.delegate?.onCancelButton()
    }
}
