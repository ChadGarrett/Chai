//
//  DBManager.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyBeaver

// TODO: Each model should probably have its own manager that inherits from this one, to avoid this managing everything

/// Base class for interacting with realm
/// To add different objects, extend this with custom CRUD implementations
final class DBManager {
    static let shared = DBManager()
    
    private var database: Realm
    
    private init() {
        database = try! Realm()
    }
    
    /// Resets/clears the database
    func deleteAllFromDatabase()  {
        try! self.database.write {
            database.deleteAll()
        }
    }
}

// TODO: Move to DBManager+Reminder.swift
extension DBManager {
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

extension DBManager {
    internal func getCurrentMood() -> Mood? {
        guard let mood = self.database.objects(Mood.self).first
            else { return nil }
        
        return mood
    }
    
    internal func setCurrentMood(to value: Float) {
        let mood: Mood
        
        // If there isn't a Mood object in Realm already, create one
        if let currentMood = self.getCurrentMood() {
            mood = currentMood
        } else {
            mood = Mood()
        }
        
        try! self.database.write { [weak self] in
            mood.value = value
            self?.database.add(mood, update: .all)
            SwiftyBeaver.verbose("Set current mood to: \(value)")
        }
    }
}
