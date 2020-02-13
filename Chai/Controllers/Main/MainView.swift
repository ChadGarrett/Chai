//
//  HomeView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit

final class MainView: BaseView {
    
    // Delegate
    
    internal weak var delegate: MainControllerDelegate?
    
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
        self.addSubview(self.stkButtons)
        
//        self.stkButtons.addArrangedSubview(self.btnAttention)
//        self.stkButtons.addArrangedSubview(self.btnMood)
//        self.stkButtons.addArrangedSubview(self.btnMemories)
        self.stkButtons.addArrangedSubview(self.btnDebitOrders)
        self.stkButtons.addArrangedSubview(self.btnPrepaidElectricity)
    }
    
    private func setupLayout() {
        self.stkButtons.autoPinEdgesToSuperviewSafeArea(with:
            UIEdgeInsets(top: Style.padding.xs, left: Style.padding.xs, bottom: Style.padding.xs, right: Style.padding.xs))
    }
    
    // Subviews
    
    private lazy var stkButtons: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Style.padding.s
        return stackView
    }()
    
    private lazy var btnAttention: GenericButton = {
        let button = GenericButton(R.string.localizable.button_attention())
        button.addTarget(self, action: #selector(onAttention), for: .touchUpInside)
        button.backgroundColor = Style.colors.alizarin
        return button
    }()
    
    private lazy var btnMood: GenericButton = {
        let button = GenericButton(R.string.localizable.button_mood())
        button.addTarget(self, action: #selector(onMood), for: .touchUpInside)
        button.backgroundColor = Style.colors.plum
        return button
    }()
    
    private lazy var btnMemories: GenericButton = {
        let button = GenericButton(R.string.localizable.button_memories())
        button.addTarget(self, action: #selector(onMemories), for: .touchUpInside)
        button.backgroundColor = Style.colors.dodgerBlue
        return button
    }()
    
    private lazy var btnMovies: GenericButton = {
        let button = GenericButton(R.string.localizable.button_movies())
        button.addTarget(self, action: #selector(onMovies), for: .touchUpInside)
        button.backgroundColor = Style.colors.wetAsphalt
        return button
    }()
    
    private lazy var btnDebitOrders: GenericButton = {
        let button = GenericButton("Debit Orders")
        button.addTarget(self, action: #selector(onDebitOrders), for: .touchUpInside)
        button.backgroundColor = Style.colors.ecstasy
        button.addDropShadow()
        return button
    }()
    
    private lazy var btnPrepaidElectricity: GenericButton = {
        let button = GenericButton("Electricity")
        button.addTarget(self, action: #selector(onPrepaidElectricity), for: .touchUpInside)
        button.backgroundColor = Style.colors.nephritis
        button.addDropShadow()
        return button
    }()
}

// Actions
extension MainView {
    @objc private func onAttention() {
        self.delegate?.onAttention()
    }
    
    @objc private func onMood() {
        self.delegate?.onMood()
    }
    
    @objc private func onMemories() {
        self.delegate?.onMemories()
    }
    
    @objc private func onMovies() {
        self.delegate?.onMovies()
    }
    
    @objc private func onDebitOrders() {
        self.delegate?.onDebitOrders()
    }
    
    @objc private func onPrepaidElectricity() {
        self.delegate?.onPrepaidElectricity()
    }
}
