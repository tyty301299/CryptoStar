//
//  CoreData.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 06/06/2022.
//

import CoreData
import Foundation

class CoreDataManager {
    static var shared = CoreDataManager()
    var context = AppDelegate.shared.persistentContainer.viewContext
    var persistentStoreCoordinator = AppDelegate.shared.persistentContainer.persistentStoreCoordinator

    // MARK: -- DELETE ALL DATA IN CORE DATA

    static func deleteCoreData<T: Codable>(name: String, completion: @escaping (ClosureResult<T>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataManager.shared.persistentStoreCoordinator.execute(deleteRequest,
                                                                          with: CoreDataManager.shared.context)
            completion(.success(data: "Success" as! T))
        } catch let error as NSError {
            completion(.failure(error: error))
        }
    }

    // MARK: - - GET ALL DATA IN CORE DATA

    static func getAllCoreData(name: String, id: String, completion: @escaping (ClosureResultCoreData) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(name)")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "\(id)", ascending: true)]

        do {
            if let coinEntities = try CoreDataManager.shared.context.fetch(fetchRequest) as? [CoinEntity] {
                completion(.success(data: coinEntities))
            } else {
                completion(.disconnected(data: "Disconnected"))
            }
        } catch let error as NSError {
            completion(.failure(error: error))
        }
    }

    // MARK: - - UPDATE DATA OF THE SWITCH IN CORE DATA

    static func updateDataSwitch<T: Codable>(coin: CoinEntity, valueSwitch: Bool, completion: @escaping (ClosureResult<T>) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: "CoinEntity", in: CoreDataManager.shared.context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "id = '\(coin.id)'")
        request.predicate = predicate
        do {
            let results =
                try CoreDataManager.shared.context.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(valueSwitch, forKey: "checkSwitch")

            do {
                try CoreDataManager.shared.context.save()
                completion(.success(data: "Record Updated!" as! T))

            } catch
            let error as NSError {
                completion(.failure(error: error))
            }
        } catch
        let error as NSError {
            completion(.failure(error: error))
        }
    }

    // MARK: - - UPDATE LOGO

    static func updateLogo<T: Codable>(coin: Coin, completion: @escaping (ClosureResult<T>) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: "CoinEntity", in: CoreDataManager.shared.context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "id = '\(coin.id)'")
        request.predicate = predicate
        do {
            let results =
                try CoreDataManager.shared.context.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(coin.logo, forKey: "logo")

            do {
                try CoreDataManager.shared.context.save()
                completion(.success(data: "Record Updated!" as! T))

            } catch
            let error as NSError {
                completion(.failure(error: error))
            }
        } catch
        let error as NSError {
            completion(.failure(error: error))
        }
    }

    // MARK: - - SAVE DATA IN CORE DATA

    static func saveCoreData<T: Codable>(dataCoin: Coin, completion: @escaping ((ClosureResult<T>) -> Void)) {
        let coin = CoinEntity(context: CoreDataManager.shared.context)
        coin.id = Int64(dataCoin.id)
        coin.name = dataCoin.name
        coin.logo = dataCoin.logo
        coin.symbol = dataCoin.symbol
        coin.priceUSD = dataCoin.priceUSD
        coin.checkSwitch = false

        do {
            try CoreDataManager.shared.context.save()
            completion(.success(data: "Success" as! T))

        } catch let error as NSError {
            completion(.failure(error: error))
        }
    }

    // MARK: - - SAVE DATA IN CORE DATA

    static func saveData<T: Codable>(dataCoin: [Coin], completion: @escaping ((ClosureResult<T>) -> Void)) {
        dataCoin.forEach { result in
            let coin = CoinEntity(context: CoreDataManager.shared.context)
            coin.id = Int64(result.id)
            coin.name = result.name
            coin.logo = result.logo
            coin.symbol = result.symbol
            coin.priceUSD = result.priceUSD
            coin.checkSwitch = false

            do {
                try CoreDataManager.shared.context.save()
                

            } catch let error as NSError {
                completion(.failure(error: error))
            }
        }
        completion(.success(data: "Success" as! T))
    }
}
