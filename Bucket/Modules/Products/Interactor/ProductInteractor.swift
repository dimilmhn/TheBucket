//
//  SceneDelegate.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/26.
//

import UIKit
import CoreData

class ProductInteractor: ProductInteractorInputProtocol {
    
    var presenter: ProductPresenter?
    private let sessionProvider = NetworkServiceProvider()

    func fetachStoredProducts() {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.productItem)
        do {
          let savedSearchRsults = try managedObjectContext.fetch(fetchRequest) as! [Product]
          presenter?.didFinishFetch(items: savedSearchRsults, error: nil)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
          presenter?.didFinishFetch(items: nil, error: error)
        }
    }
    
    func fetachWishList() -> [WishListItem]? {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.wishListItem)
        do {
            return try managedObjectContext.fetch(fetchRequest) as? [WishListItem]
        } catch {
          return nil
        }
    }
    
    func getProducts() {
        retrieveProductList(completion: { [weak self] items in
            self?.presenter?.didFinishRetrieve(items: items, error: nil)
            self?.saveProducts(items)
        }, failure: { [weak self] error in
            self?.presenter?.didFinishRetrieve(items: nil, error: error)
        })
    }
    
    func retrieveProductList(service: ProductService = ProductService(), completion: @escaping(_ list: [Product]?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        sessionProvider.request(type: [Product].self, service: service) { response in
            switch response {
            case let .success(list):
                completion(list)
            case let .failure(error):
                failure(error)
            }
        }
    }
    
    func saveProducts(_ products: [Product]?) {
        guard let productItems = products else { return }
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        self.clearProducts()
        for product in productItems {
            let entity = NSEntityDescription.insertNewObject(forEntityName: Constants.Entity.productItem, into: managedObjectContext) as! Product
            entity.id = product.id
            entity.name = product.name
            entity.details = product.details
            entity.url = product.url
            entity.price = product.price
            CoreDataStack.shared.saveContext()
        }
    }
    
    func updateWishList(_ item: Product) {
        let wishListStatus = fetachWishList()?.contains(where: { $0.id == item.id }) ?? false
        wishListStatus ? removeFromWishList(item) : saveToWishList(item)
    }
    
    private func saveToWishList(_ item: Product) {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: Constants.Entity.wishListItem, into: managedObjectContext) as! WishListItem
        entity.id = item.id
        entity.name = item.name
        entity.details = item.details
        entity.url = item.url
        entity.price = item.price
        CoreDataStack.shared.saveContext()
        presenter?.didWishListUpdate()
    }
    
    private func removeFromWishList(_ item: Product) {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.wishListItem)
        let predicate = NSPredicate(format: "id == %@", item.id ?? "")
        deleteFetch.predicate = predicate
        do {
            let _ = try managedObjectContext.fetch(deleteFetch).map { managedObjectContext.delete($0)}
            CoreDataStack.shared.saveContext()
            presenter?.didWishListUpdate()
        } catch {
            print ("There was an error")
        }
    }
    
    private func clearProducts() {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.productItem)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
            CoreDataStack.shared.saveContext()
        } catch {
            print ("There was an error")
        }
    }
}
