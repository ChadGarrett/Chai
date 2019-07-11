//
//  DBManager.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation
import RealmSwift

// TODO
// - Encrypt realm file
// - Make write transactions safer by wrapping in try catch

/// Base class for interacting with realm
/// To add different objects, inherit from this with custom CRUD implementations
class DBManager {
    
    internal var database: Realm
    
    internal init() {
        database = try! Realm()
    }
    
    /// Resets/clears the database
    func deleteAllFromDatabase()  {
        try! self.database.write {
            database.deleteAll()
        }
    }
}
