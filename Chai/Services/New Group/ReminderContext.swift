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
    /// - Parameter reminder: The reminder to be added to the database
    internal func addReminder(reminder: Reminder) {
        do {
            try database.write { [weak self] in
                reminder.id = UUID().uuidString
                self?.database.add(reminder, update: .all)
                SwiftyBeaver.verbose("Added reminder to database: \(reminder)")
            }
        } catch let error {
            SwiftyBeaver.error("Unable to add new reminder.", error.localizedDescription)
        }
    }
    
    /// Returns all reminders currently saved
    /// TODO: Implement filtering and sorting
    internal func getReminders() -> Results<Reminder> {
        let results: Results<Reminder> = self.database.objects(Reminder.self)
        return results
    }
    
    /// Returns an individual reminder based on it's index
    /// - Parameter index: The index of the reminder to be returned
    internal func getReminder(at index: Int) -> Reminder? {
        let results = self.database.objects(Reminder.self)
        guard index < results.count
            else { return nil }
        
        let item = results[index]
        return item
    }
    
    internal func deleteReminder(reminder: Reminder) {
        do {
            try self.database.write { [weak self] in
                self?.database.delete(reminder)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to delete reminder.", error.localizedDescription)
        }
    }
    
    // Aux functions
    
    /// Toggles the status of a reminder from complete <-> incomplete
    internal func toggleReminderStatus(for reminder: Reminder) {
        do {
            try database.write {
                reminder.isComplete = !reminder.isComplete
            }
        } catch let error {
            SwiftyBeaver.error("Unable to toggle a reminders status", error.localizedDescription)
        }
    }
}
