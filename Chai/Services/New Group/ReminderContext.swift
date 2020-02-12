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
    @discardableResult internal func addReminder(reminder: Reminder) -> Bool {
        do {
            try database.write { [weak self] in
                reminder.id = UUID().uuidString
                self?.database.add(reminder, update: .all)
                SwiftyBeaver.verbose("Added reminder to database: \(reminder)")
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add new reminder.", error.localizedDescription)
            return false
        }
    }
    
    /// Returns all reminders currently saved
    /// TODO: Implement filtering and sorting
    internal func getReminders() -> Results<Reminder> {
        let results: Results<Reminder> = self.database.objects(Reminder.self)
        return results
    }
    
    /// Returns a reminder for the given ID
    /// - Parameter id: Unique identifier of the reminder
    internal func getReminder(by id: Int) -> Reminder? {
        let result = self.database.object(ofType: Reminder.self, forPrimaryKey: id)
        return result
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
    
    /// Deletes the given reminder if it exists
    /// - Parameter reminder: Returns true if the reminder was deleted, false otherwise
    @discardableResult internal func deleteReminder(reminder: Reminder) -> Bool {
        do {
            SwiftyBeaver.verbose("Deleting reminder: \(reminder)")
            try self.database.write { [weak self] in
                self?.database.delete(reminder)
            }
            return true
            
        } catch let error {
            SwiftyBeaver.error("Unable to delete reminder.", error.localizedDescription)
            return false
        }
    }
    
    // Aux functions
    
    /// Toggles the status of a reminder from complete <-> incomplete
    internal func toggleReminderStatus(for reminder: Reminder) {
        do {
            SwiftyBeaver.info("Toggling reminder \"\(reminder.text)\" status to: \(reminder.isComplete)")
            try database.write {
                reminder.isComplete = !reminder.isComplete
            }
        } catch let error {
            SwiftyBeaver.error("Unable to toggle a reminders status", error.localizedDescription)
        }
    }
}
