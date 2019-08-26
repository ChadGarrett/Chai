//
//  ReminderCell.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import AttributedStringBuilder
import Reusable

extension ReminderView {
    final class ReminderCell: UITableViewCell, Reusable {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.contentView.layer.cornerRadius = 10
            self.selectionStyle = .none
            self.setupView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            self.lblReminderText.attributedText = nil
            self.lblDate.attributedText = nil
        }
        
        private func setupView() {
            self.contentView.addSubview(self.lblReminderText)
            self.contentView.addSubview(self.lblDate)
            
            self.lblReminderText.autoPinEdge(toSuperviewEdge: .top, withInset: Style.padding.s)
            self.lblReminderText.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
            self.lblReminderText.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
            
            self.lblDate.autoPinEdge(.top, to: .bottom, of: self.lblReminderText)
            self.lblDate.autoPinEdge(toSuperviewEdge: .left, withInset: Style.padding.s)
            self.lblDate.autoPinEdge(toSuperviewEdge: .right, withInset: Style.padding.s)
            self.lblDate.autoPinEdge(toSuperviewEdge: .bottom, withInset: Style.padding.s)
        }
        
        // Subviews
        
        private lazy var lblReminderText: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
        private lazy var lblDate: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
        // Setup
        
        internal func prepareForDisplay(reminder: Reminder) {
            self.setReminderText(personResponsible: reminder.personResponsible, task: reminder.text)
            self.setReminderDate(to: reminder.date)
            self.setBackground(isComplete: reminder.isComplete)
        }
        
        private func setReminderText(personResponsible: String, task: String) {
            let builder = AttributedStringBuilder()
            
            if let person = personResponsible.nonEmpty {
                builder
                    .text(person, attributes: [.font(UIFont.boldSystemFont(ofSize: UIFont.systemFontSize))])
                    .space()
                    .text("-")
                    .space()
            }
            builder.text(task)
            
            self.lblReminderText.attributedText = builder.attributedString
        }
        
        private func setReminderDate(to date: Date) {
            self.lblDate.attributedText = NSAttributedString(string: date.weekdayMonthDayHourMinute)
        }
        
        private func setBackground(isComplete: Bool) {
            self.contentView.backgroundColor = (isComplete)
                ? Style.colors.nephritis
                : Style.colors.jaffa
        }
    }
}
