//
//  LoggingService.swift
//  Chai
//
//  Created by Chad Garrett on 2019/09/16.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

import SwiftyBeaver

final class LoggingService: BaseService {
    
    let appLogger = SwiftyBeaver.self
    
    private let loggingDestinations: [BaseDestination] = [
        ConsoleDestination(),
    ]
    
    override func setup() {
        // Adds all the logging output destinations
        self.loggingDestinations.forEach { self.appLogger.addDestination($0) }
    }
}
