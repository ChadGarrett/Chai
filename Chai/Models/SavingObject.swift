//
//  SavingObject.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import RealmSwift
import SwiftyJSON

final class SavingObject: BaseObject, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionAbout: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var lastUpdated: String = ""
    @objc dynamic var colorHexCode: String = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case descriptionAbout = "description"
        case amount
        case lastUpdated = "last_updated"
        case colorHexCode = "color_hex_code"
    }
    
    func clone() -> SavingObject? {
        return self.mutableCopy() as? SavingObject
    }
    
    static func absorb(from data: JSON) -> SavingObject {
        let saving: SavingObject = SavingObject()
        saving.id = data["id"].stringValue
        saving.descriptionAbout = data["description"].stringValue
        saving.amount = data["amount"].doubleValue
        saving.lastUpdated = data["last_updated"].stringValue
        saving.colorHexCode = data["color_hex_code"].stringValue
        return saving
    }
    
    func asParameters() -> Parameters {
        let parameters: Parameters = [
            "id": self.id,
            "description": self.descriptionAbout,
            "amount": self.amount,
            "last_updated": self.lastUpdated,
            "color_hex_code": self.colorHexCode
        ]
        return parameters
    }
}
