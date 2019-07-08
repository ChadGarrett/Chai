//
//  ReminderCell.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Reusable

extension ReminderView {
    final class ReminderCell: UITableViewCell, Reusable {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setupView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            self.lblReminderText.attributedText = nil
        }
        
        private func setupView() {
            self.contentView.addSubview(self.lblReminderText)
            
            self.lblReminderText.autoPinEdgesToSuperviewEdges(
                with: UIEdgeInsets(top: Style.padding.s, left: Style.padding.s, bottom: Style.padding.s, right: Style.padding.s))
        }
        
        // Subviews
        
        private lazy var lblReminderText: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
        // Setup
        
        internal func prepareForDisplay(reminder: Reminder) {
            self.setReminderText(to: reminder.text)
            self.setBackground(isComplete: reminder.isComplete)
        }
        
        private func setReminderText(to text: String) {
            self.lblReminderText.attributedText = NSAttributedString(string: text)
        }
        
        private func setBackground(isComplete: Bool) {
            self.contentView.backgroundColor = (isComplete)
                ? Style.colors.emerald
                : Style.colors.alizarin
        }
    }
}

