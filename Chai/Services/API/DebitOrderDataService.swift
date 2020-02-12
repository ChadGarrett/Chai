//
//  DebitOrderDataService.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/11.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import SwiftyBeaver
import SwiftyJSON

final class DebitOrderDataService: APIService {
    public static func getAllDebitOrders() {
        SwiftyBeaver.info("Fetching all debit orders.")
        AF.request(Endpoints.debitOrders, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch all debit orders.", error.errorDescription ?? "")
                BannerService.shared.showBanner(title: "Unable to fetch debit orders.", style: .danger)

            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched debit orders.")
                
                let data = JSON(result)
                var debitOrders: [DebitOrder] = []

                // TODO: DebitOrder is codable, so this shouldn't be necessary
                debitOrders = data.array?.compactMap({ (responseJson: JSON) -> DebitOrder? in
                    let debitOrder: DebitOrder = DebitOrder()
                    debitOrder.id = responseJson["id"].stringValue
                    debitOrder.title = responseJson["title"].stringValue
                    debitOrder.descriptionAbout = responseJson["description"].stringValue
                    debitOrder.amount = responseJson["amount"].doubleValue
                    debitOrder.billingDate = responseJson["billing_date"].stringValue
                    debitOrder.startDate = responseJson["start_date"].stringValue
                    debitOrder.endDate = responseJson["end_date"].stringValue
                    return debitOrder
                }) ?? []

                BannerService.shared.showBanner(title: "Synced debit orders", subtitle: "Last sync: TODO", style: .success)
                SwiftyBeaver.verbose("Debit orders: \(debitOrders)")
                DebitOrderContext.shared.syncDebitOrders(debitOrders)
            }
        }
    }
}
