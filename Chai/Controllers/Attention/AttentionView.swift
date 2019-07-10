//
//  AttentionView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

final class AttentionView: AppView {
    
    // Delegate
    
    internal weak var delegate: AttentionViewDelegate?
    
    // Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.stackActions)
        self.stackActions.autoPinEdgesToSuperviewMargins(with: UIEdgeInsets(top: Style.padding.m, left: Style.padding.s, bottom: Style.padding.m, right: Style.padding.s))
    }
    
    // Subviews
    
    private lazy var stackActions: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Style.padding.m
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    // Interface
    
    internal func setActions(to actions: [AttentionType]) {
        actions.forEach { (type) in
            let button = GenericButton(type.title)
            button.backgroundColor = type.color
            button.addTarget(self, action: #selector(onAction), for: .touchUpInside)
            button.tag = type.rawValue
            self.stackActions.addArrangedSubview(button)
        }
    }
    
    // Actions
    
    @objc private func onAction(sender: GenericButton) {
        guard let type = AttentionType(rawValue: sender.tag)
            else { return }
        
        self.delegate?.onAskForAttention(of: type)
    }
}
