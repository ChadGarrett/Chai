//
//  SavingContext.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import SwiftyBeaver

final class SavingContext: DBManager {
    static let shared = SavingContext()
    
    // MARK: Sync down
    
    internal func syncSavings(_ savings: [Saving]) {
        do {
            try database.write { [weak self] in
                self?.database.add(savings, update: .modified)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync savings.", error.localizedDescription)
        }
    }
    
    // MARK: Add
    
    @discardableResult internal func add(saving: Saving) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.add(saving, update: .all)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add saving locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Update
    
    @discardableResult internal func update(saving: Saving) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.add(saving, update: .modified)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to update saving locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Delete
    
    @discardableResult internal func delete(saving: Saving) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.delete(saving)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to delete saving locally.", error.localizedDescription)
            return false
        }
    }
}
