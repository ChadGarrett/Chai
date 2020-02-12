//
//  NumberFormatter+App.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Foundation

extension NumberFormatter {
    func string(from number: Double) -> String? {
        return self.string(from: NSNumber(value: number))
    }
}
