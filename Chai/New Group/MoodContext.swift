//
//  MoodContext.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyBeaver

final class MoodContext: DBManager {
    static let shared = MoodContext()

    /// Returns the current mood object stored in realm (If any)
    internal func getCurrentMood() -> Mood? {
        guard let mood = self.database.objects(Mood.self).first
            else { return nil }

        return mood
    }

    /// Returns the current mood value
    /// Note: If no mood currently exists, one will be created
    internal func setCurrentMood(to value: Float) {
        let mood: Mood

        // If there isn't a Mood object in Realm already, create one
        if let currentMood = self.getCurrentMood() {
            mood = currentMood
        } else {
            mood = Mood()
        }

        do {
            try self.database.write { [weak self] in
                mood.value = value
                self?.database.add(mood, update: .all)
                SwiftyBeaver.verbose("Set current mood to: \(value)")
            }
        } catch let error {
            SwiftyBeaver.error("Unable to set current mood.", error.localizedDescription)
        }
    }
}
