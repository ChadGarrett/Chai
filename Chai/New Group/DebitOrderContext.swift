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
    
    internal func syncDebitOrders(_ debitOrders: [DebitOrder]) {
        do {
            try database.write { [weak self] in
                self?.database.add(debitOrders, update: .all)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync debit orders.", error.localizedDescription)
        }
    }
    
    internal func getDebitOrders() -> Results<DebitOrder> {
        let results: Results<DebitOrder> = self.database.objects(DebitOrder.self)
        return results
    }
    
    internal func getDebitOrder(by id: Int) -> DebitOrder? {
        let result = self.database.object(ofType: DebitOrder.self, forPrimaryKey: id)
        return result
    }
    
    internal func getDebitOrder(at index: Int) -> DebitOrder? {
        let results = self.database.objects(DebitOrder.self)
        guard index < results.count
            else { return nil }
        
        let item = results[index]
        return item
    }
    
    internal func updateDebitOrder(newValue: DebitOrder) {
        self.database.add(newValue, update: .modified)
    }
}
