//
//  SavingsAPIService.swift
//  Chai
//
//  Created by Chad Garrett on 2020/02/13.
//  Copyright © 2020 Chad Garrett. All rights reserved.
//

import Alamofire
import SwiftyBeaver
import SwiftyJSON

final class SavingsAPIService: APIService {
    static func fetchSavings() {
        SwiftyBeaver.info("Fetching all savings.")
        AF.request(Endpoints.savings, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch all savings.", error.localizedDescription)
                BannerService.shared.showBanner(title: "Unable to fetch all savings", style: .danger)
                
            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched savings.")
                
                let data = JSON(result)
                var savings: [Saving] = []

                // TODO: Saving is codable, so this shouldn't be necessary
                savings = data.array?.compactMap({ (responseJson: JSON) -> Saving? in
                    let saving: Saving = Saving()
                    saving.id = responseJson["id"].stringValue
                    saving.title = responseJson["title"].stringValue
                    saving.descriptionAbout = responseJson["description"].stringValue
                    saving.amount = responseJson["amount"].doubleValue
                    saving.lastUpdated = responseJson["last_updated"].stringValue
                    saving.colorHexCode = responseJson["color_hex_code"].stringValue
                    return saving
                }) ?? []
                
                BannerService.shared.showStatusBarBanner(title: "Synced savings", style: .success)
                SwiftyBeaver.verbose("Savings: \(savings)")
                SavingContext.shared.syncSavings(savings)
            }
        }
    }
}
