//
//  Users.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

enum User: Int, CaseIterable {
    case ime = 0
    case chad

    var firstName: String {
        switch self {
        case .ime: return R.string.localizable.first_name_ime()
        case .chad: return R.string.localizable.first_name_chad()
        }
    }

    var lastName: String {
        switch self {
        case .ime: return R.string.localizable.last_name_ime()
        case .chad: return R.string.localizable.last_name_chad()
        }
    }

    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
}
