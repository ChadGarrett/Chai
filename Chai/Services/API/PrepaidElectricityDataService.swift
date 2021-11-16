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
    private static let realmInterface: RealmInterface<PrepaidElectricityObject> = RealmInterface()

    // MARK: Fetch

    static func fetchPrepaidElectricity(_ onCompletion: @escaping(Result<[PrepaidElectricityObject], Error>) -> Void) {
        SwiftyBeaver.info("Fetching all prepaid electricity.")

        AF.request(Endpoints.electricity, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch prepaid electricity.", error.errorDescription ?? "")
                onCompletion(.failure(error))

            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched electricity.")

                let data = JSON(result)
                var purchases: [PrepaidElectricityObject] = []

                purchases = data.array?.compactMap({ (responseJson: JSON) -> PrepaidElectricityObject? in
                    let electricity: PrepaidElectricityObject = PrepaidElectricityObject.absorb(from: responseJson)
                    return electricity
                }) ?? []

                SwiftyBeaver.verbose("Electricties: \(purchases)")
                self.realmInterface.sync(purchases)

                onCompletion(.success(purchases))
            }
        }
    }

    // MARK: Create

    internal static func create(prepaidElectricity: PrepaidElectricityObject, _ onCompletion: @escaping(Result<PrepaidElectricityObject, Error>) -> Void) {
        SwiftyBeaver.info("Creating new prepaid electrcity.")
        SwiftyBeaver.verbose("Prepaid electricity: \(prepaidElectricity)")

        let parameters: Parameters = prepaidElectricity.asParameters()

        AF.request(Endpoints.electricity, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to create new prepaid electricity remotely.", error.localizedDescription)
                onCompletion(.failure(error))

            case .success(let returnedObject):
                let data = JSON(returnedObject)
                let newPrepaidElectricity = PrepaidElectricityObject.absorb(from: data)

                SwiftyBeaver.info("Created new prepaid electricity remotely.")
                self.realmInterface.add(object: newPrepaidElectricity)

                onCompletion(.success(newPrepaidElectricity))
            }
        }
    }

    // MARK: Update

    internal static func update(_ prepaidElectricity: PrepaidElectricityObject, _ onCompletion: @escaping(Result<PrepaidElectricityObject, Error>) -> Void) {
        SwiftyBeaver.info("Updating prepaid electricity.")
        SwiftyBeaver.verbose("Prepaid electricity: \(prepaidElectricity)")

        let parameters: Parameters = prepaidElectricity.asParameters()

        AF.request(Endpoints.electricity + prepaidElectricity.id + "/", method: .patch, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to update prepaid electricity remotely.", error.localizedDescription)
                onCompletion(.failure(error))

            case .success(let returnedObject):
                let data = JSON(returnedObject)
                let updatedPrepaidElectricity = PrepaidElectricityObject.absorb(from: data)

                SwiftyBeaver.info("Updated prepaid electricity remotely.")
                self.realmInterface.update(object: updatedPrepaidElectricity)

                onCompletion(.success(updatedPrepaidElectricity))
            }
        }
    }

    // MARK: Delete

    internal static func delete(_ prepaidElectricity: PrepaidElectricityObject, _ onCompletion: @escaping(Result<Bool, Error>) -> Void) {
        SwiftyBeaver.info("Deleting prepaid electricity.")
        SwiftyBeaver.verbose("Prepaid electricity: \(prepaidElectricity)")

        AF.request(Endpoints.electricity + prepaidElectricity.id + "/", method: .delete, headers: headers).validate().response { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to delete prepaid electrcitiy.", error.localizedDescription)
                onCompletion(.failure(error))

            case .success:
                SwiftyBeaver.info("Deleted prepaid electricity.")
                self.realmInterface.delete(object: prepaidElectricity)

                onCompletion(.success(true))
            }
        }
    }
}
