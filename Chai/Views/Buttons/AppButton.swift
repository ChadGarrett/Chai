//
//  AppButton.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/04.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

// Notes:
// - To add a new button, inherit from AppButton

/// Base class for all buttons
class AppButton: UIButton {
    
    convenience init(_ title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.showsTouchWhenHighlighted = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        // Subclasses to override
        
        // Default button properties
        self.addDropShadow()
        self.contentEdgeInsets = UIEdgeInsets(top: Style.padding.xs, left: Style.padding.s, bottom: Style.padding.xs, right: Style.padding.s)
    }
    
    override var isEnabled: Bool {
        didSet { self.isEnabledDidUpdate() }
    }
    
    private func isEnabledDidUpdate() {
        let isEnabled = self.isEnabled
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = (isEnabled) ? 1.0 : 0.5
        }
    }
}

final class GenericButton: AppButton { }

final class ConfirmButton: AppButton {
    override func setupView() {
        super.setupView()
        
        self.backgroundColor = Style.colors.emerald
    }
}

final class CancelButton: AppButton {
    override func setupView() {
        super.setupView()
        
        self.backgroundColor = Style.colors.thunderbird
    }
}
