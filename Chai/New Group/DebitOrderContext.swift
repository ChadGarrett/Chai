//
//  DebitOrderContext.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

final class DebitOrderContext: DBManager {
    static let shared = DebitOrderContext()
    
    // MARK: Sync down
    
    /// Adds all the given debit orders to Realm. To be used when syncing all data from server
    /// - Parameter debitOrders: List of debit orders to store
    internal func syncDebitOrders(_ debitOrders: [DebitOrder]) {
        do {
            try database.write { [weak self] in
                self?.database.add(debitOrders, update: .all)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync debit orders.", error.localizedDescription)
        }
    }
    
    // MARK: Add
    
    @discardableResult internal func add(debitOrder: DebitOrder) -> Bool {
        do {
            SwiftyBeaver.info("Adding debit order locally.")
            try database.write { [weak self] in
                self?.database.add(debitOrder, update: .all)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add debit order locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Update
    
    @discardableResult internal func updateDebitOrder(newValue: DebitOrder) -> Bool {
        do {
            SwiftyBeaver.info("Updating debit order locally.")
            try database.write { [weak self] in
                self?.database.add(newValue, update: .modified)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to update debit order locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Delete
    
    @discardableResult internal func delete(debitOrder: DebitOrder) -> Bool {
        do {
            SwiftyBeaver.info("Deleting debit order locally.")
            try database.write { [weak self] in
                self?.database.delete(debitOrder)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to delete debit order locally.", error.localizedDescription)
            return false
        }
    }
}
