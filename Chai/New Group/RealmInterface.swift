//
//  RealmInterface.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/17.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import SwiftyBeaver

final class RealmInterface<T: BaseObject>: DBManager {
    
    // MARK: Sync
    
    internal func sync(_ objects: [T]) {
        do {
            try database.write { [weak self] in
                self?.database.add(objects, update: .all)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync objects.", error.localizedDescription)
        }
    }
    
    // MARK: Add
    
    @discardableResult internal func add(object: T) -> Bool {
        do {
            SwiftyBeaver.info("Adding object locally.")
            try database.write { [weak self] in
                self?.database.add(object, update: .all)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add object locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Update
    
    @discardableResult internal func update(object: T) -> Bool {
        do {
            SwiftyBeaver.info("Updating object locally.")
            try database.write { [weak self] in
                self?.database.add(object, update: .modified)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to update object locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Delete
    
    @discardableResult internal func delete(object: T) -> Bool {
        do {
            SwiftyBeaver.info("Deleting object locally.")
            try self.database.write { [weak self] in
                self?.database.delete(object)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to delete object locally.", error.localizedDescription)
            return false
        }
    }
}
