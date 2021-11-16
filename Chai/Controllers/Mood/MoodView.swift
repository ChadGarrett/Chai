//
//  MoodView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import UIKit

final class MoodView: BaseView {

    // Delegate

    internal weak var delegate: MoodControllerDelegate?

    // Setup

    override func setupView() {
        super.setupView()

        self.addSubview(self.lblHeading)
        self.addSubview(self.lblBody)
        self.addSubview(self.slider)
        self.addSubview(self.lblMood)

        self.lblHeading.autoPinEdge(toSuperviewMargin: .top)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblHeading.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)

        self.lblBody.autoPinEdge(.top, to: .bottom, of: self.lblHeading, withOffset: Style.padding.s)
        self.lblBody.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblBody.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)

        self.slider.autoPinEdge(.top, to: .bottom, of: self.lblBody, withOffset: Style.padding.l)
        self.slider.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.slider.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)

        self.lblMood.autoPinEdge(.top, to: .bottom, of: self.slider, withOffset: Style.padding.l)
        self.lblMood.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
        self.lblMood.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
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

    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50 // Default - changed once date is loaded
        slider.addTarget(self, action: #selector(onMoodChange), for: .valueChanged)
        return slider
    }()

    private lazy var lblMood: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // Helpers

    internal func setMoodValue(to value: Float) {
        self.slider.setValue(value, animated: true)
    }

    internal func getMoodValue() -> Float {
        let moodValue = self.slider.value
        return moodValue
    }

    internal func setCurrentMood(to mood: MoodCategory) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = mood.color
            self?.lblMood.attributedText = NSAttributedString(string: mood.title, attributes: Style.heading_1)
        }
    }

    // Actions

    @objc private func onMoodChange() {
        let moodValue = self.slider.value
        self.delegate?.onMoodChange(to: moodValue)
    }
}
