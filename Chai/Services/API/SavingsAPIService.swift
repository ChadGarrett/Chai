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
    private static let realmInterface: RealmInterface<SavingObject> = RealmInterface()

    // MARK: Fetch

    static func fetch(_ onCompletion: @escaping (Result<[SavingObject], Error>) -> Void) {
        SwiftyBeaver.info("Fetching all savings.")
        AF.request(Endpoints.savings, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch all savings.", error.localizedDescription)
                onCompletion(.failure(error))

            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched savings.")

                let data = JSON(result)
                var savings: [SavingObject] = []

                // TODO: Saving is codable, so this shouldn't be necessary
                savings = data.array?.compactMap({ (responseJson: JSON) -> SavingObject? in
                    let saving: SavingObject = SavingObject()
                    saving.id = responseJson["id"].stringValue
                    saving.title = responseJson["title"].stringValue
                    saving.descriptionAbout = responseJson["description"].stringValue
                    saving.amount = responseJson["amount"].doubleValue
                    saving.lastUpdated = responseJson["last_updated"].stringValue
                    saving.colorHexCode = responseJson["color_hex_code"].stringValue
                    return saving
                }) ?? []

                SwiftyBeaver.verbose("Savings: \(savings)")
                self.realmInterface.sync(savings)
                onCompletion(.success(savings))
            }
        }
    }

    // MARK: Create

    static func create(_ saving: SavingObject, _ onCompletion: @escaping(Result<SavingObject, Error>) -> Void) {

    }

    // MARK: Update

    static func update(_ saving: SavingObject, _ onCompletion: @escaping(Result<SavingObject, Error>) -> Void) {

    }

    // MARK: Delete

    static func delete(_ saving: SavingObject, _ onCompletion: @escaping(Result<Bool, Error>) -> Void) {

    }
}
