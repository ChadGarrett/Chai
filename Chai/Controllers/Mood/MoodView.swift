//
//  MoodView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

final class MoodView: AppView {
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.lblHeading)
        self.addSubview(self.lblBody)
        self.addSubview(self.pbMoodStatus)
        
        self.lblHeading.autoPinEdge(toSuperviewMargin: .top)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.lblBody.autoPinEdge(.top, to: .bottom, of: self.lblHeading, withOffset: Style.padding.s)
        self.lblBody.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblBody.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        
        self.pbMoodStatus.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.pbMoodStatus.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
        self.pbMoodStatus.autoPinEdge(toSuperviewMargin: .bottom)
        
    }
    
    private var progress = Progress(totalUnitCount: 100) {
        didSet { self.progressDidUpdate() }
    }
    
    private func progressDidUpdate() {
        // TODO ?
    }
    
    // Subviews
    
    private lazy var lblHeading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: R.string.localizable.heading_mood(), attributes: Style.heading_1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var lblBody: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: R.string.localizable.mood_explanation())
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var pbMoodStatus: UIProgressView = {
        let view = UIProgressView()
        view.progress = 50.0
        view.observedProgress = self.progress
        return view
    }()
}
