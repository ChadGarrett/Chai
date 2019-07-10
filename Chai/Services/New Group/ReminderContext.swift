//
//  ReminderContext.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver
import RealmSwift

final class ReminderContext: DBManager {
    static let shared = ReminderContext()
    
    /// Adds a Reminder to the database
    internal func addReminder(reminder: Reminder) {
        try! database.write { [weak self] in
            reminder.id = UUID().uuidString
            self?.database.add(reminder, update: .all)
            SwiftyBeaver.verbose("Added reminder to database: \(reminder)")
        }
    }
    
    internal func getReminders() -> Results<Reminder> {
        let results: Results<Reminder> = self.database.objects(Reminder.self)
        return results
    }
    
    internal func getReminder(at index: Int) -> Reminder? {
        let results = self.database.objects(Reminder.self)
        guard index < results.count
            else { return nil }
        
        let item = results[index]
        return item
    }
    
    internal func toggleReminderStatus(for reminder: Reminder) {
        try! database.write {
            reminder.isComplete = !reminder.isComplete
        }
    }
}
