//
//  MoodContext.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/10.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import SwiftyBeaver
import RealmSwift

final class MoodContext: DBManager {
    static let shared = MoodContext()
    
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
