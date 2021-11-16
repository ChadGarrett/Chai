//
//  Date+App.swift
//  Chai
//
//  Created by Chad Garrett on 2019/07/09.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import Foundation

// Cheat sheet
// Tuesday, Jul 9, 2019                  EEEE, MMM d, yyyy
// 07/09/2019                            MM/dd/yyyy
// 07-09-2019 10:03                      MM-dd-yyyy HH:mm
// Jul 9, 10:03 AM                       MMM d, h:mm a
// July 2019                             MMMM yyyy
// Jul 9, 2019                           MMM d, yyyy
// Tue, 9 Jul 2019 10:03:58 +0000        E, d MMM yyyy HH:mm:ss Z
// 2019-07-09T10:03:58+0000              yyyy-MM-dd'T'HH:mm:ssZ
// 09.07.19                              dd.MM.yy
// 10:03:58.653                          HH:mm:ss.SSS

extension Date {
    var timeAndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        return dateFormatter.string(from: self)
    }

    var weekdayMonthDayHourMinute: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, HH:mm"

        return dateFormatter.string(from: self)
    }
}
