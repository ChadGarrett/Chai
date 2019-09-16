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
    
    override func setup() {
        self.appLogger.addDestination(ConsoleDestination())
    }
}
