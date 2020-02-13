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
    
    internal func syncPrepaidElectricity(_ prepaidElectricity: [PrepaidElectricity]) {
        do {
            try database.write { [weak self] in
                self?.database.add(prepaidElectricity, update: .modified)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync electricity.", error.localizedDescription)
        }
    }
    
    internal func getElectricity() -> Results<PrepaidElectricity> {
        let results: Results<PrepaidElectricity> = self.database.objects(PrepaidElectricity.self)
        return results
    }
    
    internal func getElectricity(at index: Int) -> PrepaidElectricity? {
        let results = self.database.objects(PrepaidElectricity.self)
        guard index < results.count
            else { return nil }
        
        let item = results[index]
        return item
    }
}
