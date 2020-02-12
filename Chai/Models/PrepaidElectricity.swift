//
//  PrepaidElectricity.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift

final class PrepaidElectricity: BaseObject, Codable {
    @objc dynamic var buyer: String = ""
    @objc dynamic var randAmount: Double = 0.0
    @objc dynamic var charges: Double = 0.0
    @objc dynamic var amountBought: Double = 0.0
    @objc dynamic var dateBought: String = ""
    
    enum CodingKeys: String, CodingKey {
      case buyer
      case randAmount = "rand_amount"
      case charges
      case amountBought = "amount_bought"
      case dateBought = "date_bought"
    }
}
