//
//  APIService.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire

class APIService {

    // TODO: Get the server URL from the plist for the different build targets
    // TODO: Proper authentication with a non hardcoded token

    static let baseURL: String = "http://127.0.0.1:8000/"

    static let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "Token 7eda9fe3bde210c9ace7a339c658b1d337adc142"
    ]
}

// MARK: Endpoints

extension APIService {
    struct Endpoints {
        static let debitOrders: String = APIService.baseURL + "personal/debitorders/"
        static let electricity: String = APIService.baseURL + "personal/electricity/"
        static let savings: String = APIService.baseURL + "personal/savings/"
    }
}
