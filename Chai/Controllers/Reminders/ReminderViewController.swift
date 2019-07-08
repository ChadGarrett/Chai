//
//  ReminderViewController.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import NotificationBannerSwift
import SwiftyBeaver

protocol ReminderControllerDelegate: class {
    func onAddReminder(reminder: Reminder)
}

final class ReminderViewController: AppViewController {
    
    // View
    
    private lazy var reminderView: ReminderView = {
        let view = ReminderView()
        view.delegate = self
        return view
    }()
    
    // Setup
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.addSubview(self.reminderView)
        self.reminderView.autoPinEdgesToSuperviewEdges()
    }
    
    // Data
    
    private var reminders: [Reminder] = [] {
        didSet { self.remindersDidUpdate() }
    }
    
    private func remindersDidUpdate() {
        self.reminderView.reminders = self.reminders
    }
}

extension ReminderViewController: ReminderControllerDelegate {
    func onAddReminder(reminder: Reminder) {
        SwiftyBeaver.info("Adding new reminder to list.")
        SwiftyBeaver.verbose("Adding reminder: \"\(reminder.text)\" due \"\(reminder.date)\"")
        
        self.reminders.append(reminder)
        self.showAddBanner(text: reminder.text)
    }
    
    private func showAddBanner(text: String) {
        BannerService.shared.showBanner(title: "Reminder added!", subtitle: text, style: .success)
    }
}
