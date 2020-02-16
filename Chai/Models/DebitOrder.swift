//
//  DebitOrder.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import RealmSwift
import SwiftyJSON

final class DebitOrder: BaseObject, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionAbout: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var billingDate: String = ""
    @objc dynamic var startDate: String = ""
    @objc dynamic var endDate: String = ""
    
    enum CodingKeys: String, CodingKey {
      case title = "title"
      case descriptionAbout = "description"
      case amount = "amount"
      case billingDate = "billing_date"
      case startDate = "start_date"
      case endDate = "end_date"
    }

    func clone() -> DebitOrder? {
        return self.mutableCopy() as? DebitOrder
    }
    
    static func absorb(from data: JSON) -> DebitOrder {
        let debitOrder: DebitOrder = DebitOrder()
        debitOrder.id = data["id"].stringValue
        debitOrder.title = data["title"].stringValue
        debitOrder.descriptionAbout = data["description"].stringValue
        debitOrder.amount = data["amount"].doubleValue
        debitOrder.billingDate = data["billing_date"].stringValue
        debitOrder.startDate = data["start_date"].stringValue
        debitOrder.endDate = data["end_date"].stringValue
        return debitOrder
    }
    
    func asParameters() -> Parameters {
        let parameters: Parameters = [
            "id": self.id,
            "title": self.title,
            "description": self.descriptionAbout,
            "amount": self.amount,
            "billing_date": self.billingDate,
            "start_date": self.startDate,
            "end_date": self.endDate
        ]
        return parameters
    }
}
