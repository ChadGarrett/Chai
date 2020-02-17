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
    private static let realmInterface: RealmInterface<DebitOrder> = RealmInterface()
    
    // MARK: Fetch
    
    public static func fetchDebitOrders(_ onCompletion: @escaping(Result<[DebitOrder], Error>) -> Void) {
        SwiftyBeaver.info("Fetching all debit orders.")
        AF.request(Endpoints.debitOrders, method: .get, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to fetch all debit orders.", error.localizedDescription)
                onCompletion(.failure(error))

            case .success(let result):
                SwiftyBeaver.info("Succesfully fetched debit orders.")
                
                let data = JSON(result)
                var debitOrders: [DebitOrder] = []

                debitOrders = data.array?.compactMap({ (responseJson: JSON) -> DebitOrder? in
                    let debitOrder: DebitOrder = DebitOrder.absorb(from: responseJson)
                    return debitOrder
                }) ?? []

                SwiftyBeaver.verbose("Debit orders: \(debitOrders)")
                self.realmInterface.sync(debitOrders)
                
                onCompletion(.success(debitOrders))
            }
        }
    }
    
    // MARK: Create
    
    public static func createDebitOrder(debitOrder: DebitOrder, _ onCompletion: @escaping(Result<DebitOrder, Error>) -> Void) {
        SwiftyBeaver.info("Creating new debit order.")
        SwiftyBeaver.verbose("Debit order: \(debitOrder)")
        
        let parameters: Parameters = debitOrder.asParameters()
        
        AF.request(Endpoints.debitOrders, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to create new debit order", error.localizedDescription)
                onCompletion(.failure(error))
                
            case .success(let returnedObject):
                let data = JSON(returnedObject)
                let newDebitOrder = DebitOrder.absorb(from: data)
                
                SwiftyBeaver.info("Created new debit order remotely.")
                self.realmInterface.add(object: newDebitOrder)
                
                onCompletion(.success(debitOrder))
            }
        }
    }
    
    // MARK: Update
    
    public static func updateDebitOrder(debitOrder: DebitOrder, _ onCompletion: @escaping(Result<DebitOrder, Error>) -> Void) {
        SwiftyBeaver.info("Updating debit order.")
        SwiftyBeaver.verbose("Debit order: \(debitOrder)")
        
        let parameters: Parameters = debitOrder.asParameters()
        
        AF.request(Endpoints.debitOrders + debitOrder.id + "/", method: .patch, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                SwiftyBeaver.error("Unable to update debit order.", error.localizedDescription)
                onCompletion(.failure(error))
                
            case .success(let responseObject):
                let data = JSON(responseObject)
                let updatedDebitOrder = DebitOrder.absorb(from: data)
                
                SwiftyBeaver.info("Updated debit order remotely.")
                self.realmInterface.update(object: updatedDebitOrder)
                
                onCompletion(.success(updatedDebitOrder))
            }
        }
    }
    
    // MARK: Delete
    
    public static func deleteDebitOrder(debitOrder: DebitOrder, _ onCompletion: @escaping(Result<Bool, Error>) -> Void) {
        SwiftyBeaver.info("Deleting debit order.")
        SwiftyBeaver.verbose("Debit order: \(debitOrder)")
        
        AF.request(Endpoints.debitOrders + debitOrder.id + "/", method: .delete, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                SwiftyBeaver.error("Unable to delete debit order.", error.localizedDescription)
                onCompletion(.failure(error))
                
            case .success:
                SwiftyBeaver.info("Deleted deit order remotely.")
                self.realmInterface.delete(object: debitOrder)
                
                onCompletion(.success(true))
            }
        }
    }
}

/*
 
 let json = JSON(responseObject)
                 guard let data = response.data else { return }
                 
                 do {
                     let decoder = JSONDecoder()
 //                    let root = try decoder.decode(DebitOrder.self, from: data)
 //                    SwiftyBeaver.debug("\(root)")
                     
                     let repos =  try JSONDecoder().decode([DebitOrder].self, from: data)
                     SwiftyBeaver.debug("\(repos)")
                 }
                 catch let error {
                     SwiftyBeaver.error("Bigerror", error.localizedDescription)
                 }
 */
