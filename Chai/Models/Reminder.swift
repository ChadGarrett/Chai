//
//  Reminder.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/08.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import RealmSwift

final class Reminder: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var isComplete: Bool = false
}
