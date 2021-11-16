//
//  BaseService.swift
//  Chai
//
//  Created by Chad Garrett on 2019/09/16.
//  Copyright © 2019 Chad Garrett. All rights reserved.
//

protocol BaseService {
    /// Call this to setup the service - used in AppDelegate
    func setup()

    func teardown()
}

extension BaseService {
    // Default implementation - not all services require a teardown
    func teardown() {}
}
