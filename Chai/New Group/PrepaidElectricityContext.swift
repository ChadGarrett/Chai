//
//  PrepaidElectricityContext.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift
import SwiftyBeaver

final class PrepaidElectricityContext: DBManager {
    static let shared = PrepaidElectricityContext()
    
    // MARK: Sync down
    
    internal func syncPrepaidElectricity(_ prepaidElectricity: [PrepaidElectricity]) {
        do {
            try database.write { [weak self] in
                self?.database.add(prepaidElectricity, update: .modified)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync electricity.", error.localizedDescription)
        }
    }
    
    // MARK: Add
    
    @discardableResult internal func add(prepaidElectricity: PrepaidElectricity) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.add(prepaidElectricity, update: .all)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add Prepaid Electricity locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Update
    
    @discardableResult internal func update(prepaidElectricity: PrepaidElectricity) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.add(prepaidElectricity, update: .modified)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to update Prepaid Electrciy locally.", error.localizedDescription)
            return false
        }
    }
    
    // MARK: Delete
    
    @discardableResult internal func delete(prepaidElectrcity: PrepaidElectricity) -> Bool {
        do {
            try database.write { [weak self] in
                self?.database.delete(prepaidElectrcity)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to delete Prepaid Electricity locally.", error.localizedDescription)
            return false
        }
    }
}
