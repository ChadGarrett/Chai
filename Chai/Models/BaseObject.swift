//
//  BaseObject.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import RealmSwift

class BaseObject: Object {
    @objc dynamic var id: String = ""
    
    override internal static func primaryKey() -> String? {
        return "id"
    }
}
