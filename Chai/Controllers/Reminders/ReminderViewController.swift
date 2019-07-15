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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = R.string.localizable.title_reminders()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        SwiftyBeaver.verbose("Adding reminder: \"\(reminder.text)\" due \"\(reminder.date)\"")
        
        ReminderContext.shared.addReminder(reminder: reminder)
        
        self.showAddBanner(text: reminder.text)
    }
    
    func onDeleteReminder(reminder: Reminder) {
        SwiftyBeaver.info("Deleting reminder.")
        SwiftyBeaver.verbose("Deleting reminder: \(reminder.text)")
        
        ReminderContext.shared.deleteReminder(reminder: reminder)
    }
    
    private func showAddBanner(text: String) {
        BannerService.shared.showBanner(title: "Reminder added!", subtitle: text, style: .success)
    }
    
    private func showDeleteBanner() {
        BannerService.shared.showBanner(title: "Reminder deleted", style: .info)
    }
}
