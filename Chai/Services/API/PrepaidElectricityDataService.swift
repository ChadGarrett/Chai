//
//  PrepaidElectricityDataService.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/12.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import SwiftyBeaver
import SwiftyJSON

final class PrepaidElectricityDataService: APIService {
    
    static func fetchPrepaidElectricity(_ onCompletion: @escaping(Result<[PrepaidElectricity], Error>) -> Void) {
        SwiftyBeaver.info("Fetching all prepaid electricity.")
        
        AF.request(Endpoints.electricity, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch prepaid electricity.", error.errorDescription ?? "")
                onCompletion(.failure(error))

            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched electricity.")
                
                let data = JSON(result)
                var purchases: [PrepaidElectricity] = []

                // TODO: PrepaidElectricity is codable, so this shouldn't be necessary
                purchases = data.array?.compactMap({ (responseJson: JSON) -> PrepaidElectricity? in
                    let electricity: PrepaidElectricity = PrepaidElectricity()
                    electricity.id = responseJson["id"].stringValue
                    electricity.buyer = responseJson["buyer"].stringValue
                    electricity.randAmount = responseJson["rand_amount"].doubleValue
                    electricity.charges = responseJson["charges"].doubleValue
                    electricity.amountBought = responseJson["amount_bought"].doubleValue
                    electricity.dateBought = responseJson["date_bought"].stringValue
                    return electricity
                }) ?? []
                
                SwiftyBeaver.verbose("Electricties: \(purchases)")
                PrepaidElectricityContext.shared.syncPrepaidElectricity(purchases)
                onCompletion(.success(purchases))
            }
        }
    }
}
