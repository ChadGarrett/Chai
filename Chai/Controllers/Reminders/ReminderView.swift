//
//  ReminderView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import SwiftyBeaver
import UIKit

// Section at top to add new reminders
// Table view of reminders previously sent

final class ReminderView: AppView {
    
    // Delegate
    
    internal weak var delegate: ReminderControllerDelegate?
    
    // Data
    
    internal var reminders: [Reminder] = [] {
        didSet { self.remindersDidUpdate() }
    }
    
    private func remindersDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tblReminders.reloadData()
        }
    }
    
    // Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwAddReminder)
        self.addSubview(self.tblReminders)
        
        self.vwAddReminder.autoPinEdge(toSuperviewMargin: .top)
        self.vwAddReminder.autoPinEdge(toSuperviewMargin: .left)
        self.vwAddReminder.autoPinEdge(toSuperviewMargin: .right)
        
        self.tblReminders.autoPinEdge(.top, to: .bottom, of: self.vwAddReminder)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .left)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .right)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .bottom)
    }
    
    // Subviews
    
    private lazy var vwAddReminder: ReminderAddView = {
        let view = ReminderAddView()
        view.delegate = self
        return view
    }()
    
    private lazy var tblReminders: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: ReminderCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

extension ReminderView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reminder = self.reminders.item(at: indexPath.row)
            else { return self.getBlankTableCell(for: indexPath) }
        
        return self.getReminderCell(for: indexPath, with: reminder)
    }
    
    private func getBlankTableCell(for indexPath: IndexPath) -> UITableViewCell {
        return self.tblReminders.dequeueReusableCell(for: indexPath, cellType: BlankTableCell.self)
    }
    
    private func getReminderCell(for indexPath: IndexPath, with reminder: Reminder) -> UITableViewCell {
        let cell: ReminderCell = self.tblReminders.dequeueReusableCell(for: indexPath)
        cell.prepareForDisplay(reminder: reminder)
        return cell
    }
}

extension ReminderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reminder = self.reminders.item(at: indexPath.row)
            else { return }
        
        self.toggleReminderStatus(for: reminder)
    }
    
    /// Toggles the reminders state between complete and incomplete
    private func toggleReminderStatus(for reminder: Reminder) {
        SwiftyBeaver.info("Toggling reminder \"\(reminder.text)\" complete state to: \(reminder.isComplete)")
        reminder.isComplete = !reminder.isComplete
    }
}

extension ReminderView: ReminderAddViewDelegate {
    func onAdd() {
        let reminder = self.vwAddReminder.getReminder()
        self.delegate?.onAddReminder(reminder: reminder)
    }
}

// TODO: Move this cell to its own file

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
