//
//  APIService.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire

class APIService {
    
    // TODO: toggle this based on build targets for dev/prod
    static let baseURL: String = "http://127.0.0.1:8000/"
    
    static let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
}

// MARK: Endpoints

extension APIService {
    struct Endpoints {
        static let debitOrders: String = APIService.baseURL + "personal/debitorders/"
    }
}
