//
//  DebitOrder.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift

final class DebitOrder: BaseObject, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionAbout: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var billingDate: String = ""
    @objc dynamic var startDate: String = ""
    @objc dynamic var endDate: String = ""
    
    enum CodingKeys: String, CodingKey {
      case title
      case descriptionAbout = "description"
      case amount
      case billingDate = "billing_date"
      case startDate = "start_date"
      case endDate = "end_date"
    }
}
