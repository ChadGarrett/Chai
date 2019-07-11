//
//  BaseObject.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import RealmSwift

/// Base object that all objects which are going to be stored in realm should inherit from
class BaseObject: Object {
    @objc dynamic var id: String = ""
    
    override internal static func primaryKey() -> String? {
        return "id"
    }
}
