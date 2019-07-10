//
//  HomeView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/03/14.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

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
        self.addSubview(self.vwCenter)
        
        self.addSubview(self.btnRemind)
        self.addSubview(self.btnAttention)
        self.addSubview(self.btnMood)
        self.addSubview(self.btnMemories)
    }
    
    private func setupLayout() {
        self.vwCenter.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        self.vwCenter.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        self.vwCenter.autoSetDimensions(to: CGSize(width: 0.1, height: 0.1))
        
        self.btnRemind.autoPinEdge(toSuperviewMargin: .top, withInset: Style.padding.m)
        self.btnRemind.autoPinEdge(toSuperviewMargin: .left, withInset: Style.padding.s)
        self.btnRemind.autoPinEdge(.right, to: .left, of: self.vwCenter, withOffset: -Style.padding.xs)
        self.btnRemind.autoPinEdge(.bottom, to: .top, of: self.vwCenter, withOffset: -Style.padding.xs)
        
        self.btnAttention.autoPinEdge(toSuperviewMargin: .top, withInset: Style.padding.m)
        self.btnAttention.autoPinEdge(.left, to: .right, of: self.vwCenter, withOffset: Style.padding.xs)
        self.btnAttention.autoPinEdge(toSuperviewMargin: .right, withInset: Style.padding.s)
        self.btnAttention.autoPinEdge(.bottom, to: .top, of: self.vwCenter, withOffset: -Style.padding.xs)
        
        self.btnMood.autoPinEdge(.top, to: .bottom, of: self.vwCenter, withOffset: Style.padding.xs)
        self.btnMood.autoPinEdge(toSuperviewMargin: .left, withInset: Style.padding.s)
        self.btnMood.autoPinEdge(.right, to: .left, of: self.vwCenter, withOffset: -Style.padding.xs)
        self.btnMood.autoPinEdge(toSuperviewMargin: .bottom, withInset: Style.padding.m)
        
        self.btnMemories.autoPinEdge(.top, to: .bottom, of: self.vwCenter, withOffset: Style.padding.xs)
        self.btnMemories.autoPinEdge(.left, to: .right, of: self.vwCenter, withOffset: Style.padding.xs)
        self.btnMemories.autoPinEdge(toSuperviewMargin: .right, withInset: Style.padding.s)
        self.btnMemories.autoPinEdge(toSuperviewMargin: .bottom, withInset: Style.padding.m)
    }
    
    // Subviews
    
    /// Placed in the center of the screen and used to align the button grid
    private lazy var vwCenter = UIView()
    
    private lazy var btnRemind: GenericButton = {
        let button = GenericButton(R.string.localizable.button_remind())
        button.addTarget(self, action: #selector(onRemind), for: .touchUpInside)
        button.backgroundColor = Style.colors.jaffa
        return button
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
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 45, style: .regular)
        button.setTitle(String.fontAwesomeIcon(name: .smile), for: .normal)
        return button
    }()
    
    private lazy var btnMemories: GenericButton = {
        let button = GenericButton(R.string.localizable.button_memories())
        
        button.addTarget(self, action: #selector(onMemories), for: .touchUpInside)
        button.backgroundColor = Style.colors.dodgerBlue
        return button
    }()
}

// Actions
extension HomeView {
    @objc private func onRemind() {
        self.delegate?.onRemind()
    }
    
    @objc private func onAttention() {
        self.delegate?.onAttention()
    }
    
    @objc private func onMood() {
        self.delegate?.onMood()
    }
    
    @objc private func onMemories() {
        self.delegate?.onMemories()
    }
}
