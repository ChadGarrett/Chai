//
//  ReminderView.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import SwiftyBeaver
import UIKit
import RealmSwift

// Section at top to add new reminders
// Table view of reminders previously sent

final class ReminderView: AppView {
    
    // Delegate
    
    internal weak var delegate: ReminderControllerDelegate?
    
    // Setup
    
    override func setupView() {
        super.setupView()
        
        self.addSubview(self.vwAddReminder)
        self.addSubview(self.tblReminders)
        
        self.vwAddReminder.autoPinEdge(toSuperviewSafeArea: .top)
        self.vwAddReminder.autoPinEdge(toSuperviewEdge: .left)
        self.vwAddReminder.autoPinEdge(toSuperviewEdge: .right)
        
        self.tblReminders.autoPinEdge(.top, to: .bottom, of: self.vwAddReminder, withOffset: Style.padding.s)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .left)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .right)
        self.tblReminders.autoPinEdge(toSuperviewMargin: .bottom)
    }
    
    private var token: NotificationToken?
    
    /// Starts listening for updates in realm
    internal func startData() {
        DispatchQueue.main.async { [weak self] in
            self?.token?.invalidate()
            self?.token = ReminderContext.shared.getReminders().observe { (changes: RealmCollectionChange) in
                DispatchQueue.main.async {
                    switch changes {
                    case .initial:
                        self?.tblReminders.reloadData()
                        
                    case .update(_, let deletions, let insertions, let modifications):
                        self?.tblReminders.beginUpdates()
                        self?.tblReminders.insertRows(
                            at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tblReminders.deleteRows(
                            at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                        self?.tblReminders.reloadRows(
                            at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tblReminders.endUpdates()
                        
                    case .error(let error):
                        SwiftyBeaver.error("Unable to update table", error.localizedDescription)
                    }
                }
            }
        }
    }
    
    /// Stops listening for updates in realm
    internal func stopData() {
        self.token?.invalidate()
    }
    
    // Subviews
    
    private lazy var vwAddReminder: AddReminderView = {
        let view = AddReminderView()
        view.delegate = self
        return view
    }()
    
    private lazy var tblReminders: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: ReminderCell.self)
        tableView.register(cellType: BlankTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(inset: Style.padding.xs)
        return tableView
    }()
}

extension ReminderView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderContext.shared.getReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reminder = ReminderContext.shared.getReminder(at: indexPath.row)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.getTrailingSwipeActions(for: indexPath)
    }
    
    private func getTrailingSwipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration {
        guard let reminder = ReminderContext.shared.getReminder(at: indexPath.row)
            else { return UISwipeActionsConfiguration() }
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: R.string.localizable.button_delete(),
            handler: { [weak self] (_, _, _) in self?.onDelete(reminder: reminder) })
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    private func onDelete(reminder: Reminder) {
        self.delegate?.onDeleteReminder(reminder: reminder)
    }
}

extension ReminderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reminder = ReminderContext.shared.getReminder(at: indexPath.row)
            else { return }

        SwiftyBeaver.info("Toggling reminder \"\(reminder.text)\" complete state to: \(reminder.isComplete)")
        ReminderContext.shared.toggleReminderStatus(for: reminder)
    }
}

extension ReminderView: AddReminderDelegate {
    func onAdd() {
        guard let reminder = self.vwAddReminder.getReminder() else {
            SwiftyBeaver.error("Unable to fetch reminder from view when adding.")
            return
        }
        
        self.delegate?.onAddReminder(reminder: reminder)
    }
}
