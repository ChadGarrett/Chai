//
//  DateHelper.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/17.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Foundation

final class DateHelper {
    static func stringToDate(string date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
    
    static func dateToString(date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

