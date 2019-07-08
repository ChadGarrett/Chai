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
        
        self.tblReminders.autoPinEdge(.top, to: .bottom, of: self.vwAddReminder, withOffset: Style.padding.s)
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
        guard let reminder = self.vwAddReminder.getReminder() else {
            SwiftyBeaver.warning("Unable to fetch reminder from view when adding.")
            return
        }
        
        self.delegate?.onAddReminder(reminder: reminder)
    }
}
