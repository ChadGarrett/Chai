//
//  String+Kalido.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/11.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation

extension String {
    // Removes whitespace from the both sides of a string
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    var nonEmpty: String? {
        return self.trimmed.isEmpty ? nil : self
    }
}
