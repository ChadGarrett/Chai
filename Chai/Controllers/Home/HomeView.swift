//
//  HomeView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit

final class HomeView: AppView {
    
    // Delegate
    
    internal weak var delegate: HomeControllerDelegate?
    
    // Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupSubviews()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(self.vwAcceptButton)
    }
    
    private func setupLayout() {
        self.vwAcceptButton.autoPinEdge(toSuperviewMargin: .left, withInset: Style.padding.s)
        self.vwAcceptButton.autoPinEdge(toSuperviewMargin: .right, withInset: Style.padding.s)
        self.vwAcceptButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: Style.padding.s)
    }
    
    // Subviews

    private lazy var vwAcceptButton: AcceptCancelButtonView = {
        let view = AcceptCancelButtonView()
        view.delegate = self
        return view
    }()
}

// Actions
extension HomeView: AcceptCancelButtonDelegate {
    func onAcceptButton() {
        // TODO
    }
    
    func onCancelButton() {
        // TODO
    }
}
