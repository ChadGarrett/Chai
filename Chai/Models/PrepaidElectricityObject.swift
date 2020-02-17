//
//  PrepaidElectricityObject.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import RealmSwift
import SwiftyJSON

final class PrepaidElectricityObject: BaseObject, Codable {
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
    
    func clone() -> PrepaidElectricityObject? {
        return self.mutableCopy() as? PrepaidElectricityObject
    }
    
    static func absorb(from data: JSON) -> PrepaidElectricityObject {
        let prepaidElectricity: PrepaidElectricityObject = PrepaidElectricityObject()
        prepaidElectricity.id = data["id"].stringValue
        prepaidElectricity.randAmount = data["rand_amount"].doubleValue
        prepaidElectricity.charges = data["charges"].doubleValue
        prepaidElectricity.amountBought = data["amount_bought"].doubleValue
        prepaidElectricity.dateBought = data["date_bought"].stringValue
        return prepaidElectricity
    }
    
    func asParameters() -> Parameters {
        let parameters: Parameters = [
            "id": self.id,
            "buyer": self.buyer,
            "rand_amount": self.randAmount,
            "charges": self.charges,
            "amount_bought": self.amountBought,
            "date_bought": self.dateBought
        ]
        return parameters
    }
}
