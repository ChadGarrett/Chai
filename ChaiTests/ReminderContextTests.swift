//
//  ReminderContextTests.swift
//  ChaiTests
//
//  Created by Chad Garrett on 2019/07/16.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import XCTest

@testable import Chai

class ReminderContextTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        // Reset the DB for each test
        ReminderContext.shared.deleteAllFromDatabase()
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Helpers
    
    private func createRandomReminder() -> Reminder {
        let reminder: Reminder = Reminder()
        reminder.text = "ExampleReminder"
        reminder.isComplete = false
        reminder.personResponsible = "Troy"
        reminder.date = Date()
        return reminder
    }
    
    // Tests

    /// Tests adding a reminder to Realm
    func testAddingAReminder() {
        var isDatabaseEmpty = (ReminderContext.shared.getReminders().count == 0)
        XCTAssertTrue(isDatabaseEmpty, "Database is not empty.")
        
        let reminder = self.createRandomReminder()
        ReminderContext.shared.addReminder(reminder: reminder)
        
        isDatabaseEmpty = (ReminderContext.shared.getReminders().count == 0)
        XCTAssertFalse(isDatabaseEmpty, "Reminder was not added to Realm.")
    }
    
    /// Tests deleting a reminder from Realm
    func testDeletingReminder() {
        let reminder = self.createRandomReminder()
        ReminderContext.shared.addReminder(reminder: reminder)
        
        // Test the reminder is in the database
        let numberOfRemindersBeforeDelete = ReminderContext.shared.getReminders().count
        XCTAssertEqual(numberOfRemindersBeforeDelete, 1, "Expected one Reminder to be in the database.")
        
        // Delete the reminder
        ReminderContext.shared.deleteReminder(reminder: reminder)
        
        let numberOfRemindersAfterDelete = ReminderContext.shared.getReminders().count
        XCTAssertEqual(numberOfRemindersAfterDelete, 0, "Expected the database to be empty after deleting a reminder.")
    }
    
    /// Test that fetching all the reminders returns the correct amount
    func testFetchingAllReminders() {
        /// Add three test reminders
        let reminderOne = self.createRandomReminder()
        
        let reminderTwo = self.createRandomReminder()
        
        let reminderThree = self.createRandomReminder()
        
        ReminderContext.shared.addReminder(reminder: reminderOne)
        ReminderContext.shared.addReminder(reminder: reminderTwo)
        ReminderContext.shared.addReminder(reminder: reminderThree)
        
        // Expect 3 reminders to be returned
        let allReminders = ReminderContext.shared.getReminders()
        
        XCTAssertEqual(allReminders.count, 3, "Expected three reminders to be returned when fetching all.")
        
        // Expect all added reminders to be there
        let containsReminderOne: Bool = allReminders.contains(reminderOne)
        let containsReminderTwo: Bool = allReminders.contains(reminderTwo)
        let containsReminderThree: Bool = allReminders.contains(reminderThree)

        XCTAssertTrue(containsReminderOne, "Reminder one was not in the result set")
        XCTAssertTrue(containsReminderTwo, "Reminder two was not in the result set")
        XCTAssertTrue(containsReminderThree, "Reminder three was not in the result set")
    }
    
    /// Test fetching a specific reminder
    func testFetchingSpecificReminder() {
        /// Add a test reminder
        let reminder = self.createRandomReminder()
        ReminderContext.shared.addReminder(reminder: reminder)
        
        // Check that the reminder could be fetched
        let reminderExists = ReminderContext.shared.getReminder(at: 0)
        XCTAssertNotNil(reminderExists, "Failed to retrieve a specific reminder from Realm.")
        
        // Check that it was the right reminder returned
        XCTAssertEqual(reminder.id, reminderExists?.id ?? "", "Reminder fetched does not match the one we were looking for.")
        
        // Check that fetching a reminder out of bounds does not return one
        let reminderDoesNotExist = ReminderContext.shared.getReminder(at: 9999)
        XCTAssertNil(reminderDoesNotExist, "Fetch a reminder from the database when there should not have been one.")
    }
    
    /// Test updating a reminders status (from complete, to incomplete and back)
    func testUpdatingReminderStatus() {
        let initialReminder = self.createRandomReminder()
        ReminderContext.shared.addReminder(reminder: initialReminder)
        
        // Fetch the reminder from the database and check its initial completness
        if let reminder = ReminderContext.shared.getReminder(at: 0) {
            // The reminder should start as being incomplete
            XCTAssertFalse(reminder.isComplete, "Reminder should not be complete yet")
        }
        
        // Change it's status
        ReminderContext.shared.toggleReminderStatus(for: initialReminder)
        
        // Fetch the reminder again and check that the completeness has changed
        if let reminder = ReminderContext.shared.getReminder(at: 0) {
            XCTAssertTrue(reminder.isComplete, "Reminder status did not toggle to complete.")
        }
    }
}
