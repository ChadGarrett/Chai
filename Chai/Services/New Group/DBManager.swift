//
//  DBManager.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

// TODO
// - Encrypt realm file

/// Base class for interacting with realm
/// To add different objects, inherit from this with custom CRUD implementations
class DBManager {
    
    internal var database: Realm
    
    internal init() {
        do {
            database = try Realm()
        } catch let error {
            SwiftyBeaver.debug(error)
            SwiftyBeaver.error("Unable to initialize Realm.", error.localizedDescription)
            fatalError("Unable to initialize Realm instance.")
        }
    }
    
    /// Resets/clears the database
    func deleteAllFromDatabase() {
        do {
            try self.database.write {
                database.deleteAll()
            }
        } catch let error {
            SwiftyBeaver.error("Unable to delete all data from realm.", error.localizedDescription)
        }
    }
}
