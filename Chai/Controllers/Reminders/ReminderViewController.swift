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
    func onDeleteReminder(reminder: Reminder)
}

final class ReminderViewController: AppViewController {
    
    // View
    
    private lazy var reminderView: ReminderView = {
        let view = ReminderView()
        view.delegate = self
        return view
    }()
    
    // Setup
    
    override init() {
        super.init()
        self.title = R.string.localizable.title_reminders()
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.reminderView)
        self.reminderView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reminderView.startData()
    }
    
    deinit {
        self.reminderView.stopData()
    }
}

extension ReminderViewController: ReminderControllerDelegate {
    func onAddReminder(reminder: Reminder) {
        SwiftyBeaver.info("Adding new reminder to list.")
        
        if ReminderContext.shared.addReminder(reminder: reminder) {        
            self.showAddBanner(text: reminder.text)
        }
    }
    
    func onDeleteReminder(reminder: Reminder) {
        SwiftyBeaver.info("Deleting reminder.")
        
        if ReminderContext.shared.deleteReminder(reminder: reminder) {
            self.showDeleteBanner()
        }
    }
    
    private func showAddBanner(text: String) {
        BannerService.shared.showBanner(title: "Reminder added!", subtitle: text, style: .success)
    }
    
    private func showDeleteBanner() {
        BannerService.shared.showBanner(title: "Reminder deleted", style: .info)
    }
}
