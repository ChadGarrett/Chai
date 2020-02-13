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
    
    internal func syncSavings(_ savings: [Saving]) {
        do {
            try database.write { [weak self] in
                self?.database.add(savings, update: .modified)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync savings.", error.localizedDescription)
        }
    }
}
