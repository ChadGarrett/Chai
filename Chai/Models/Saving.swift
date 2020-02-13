//
//  Saving.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import RealmSwift

final class Saving: BaseObject {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionAbout: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var lastUpdated: String = ""
    @objc dynamic var colorHexCode: String = ""
}
