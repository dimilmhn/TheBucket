//
//  WishListInteractor.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import Foundation
import CoreData

class WishListInteractor: WishListInteractorInputProtocol {
    var presenter: WishListPresenter?
    
    func fetachWishList() {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.wishListItem)
        do {
            let wishList =  try managedObjectContext.fetch(fetchRequest) as? [WishListItem]
            presenter?.didFinishFetch(items: wishList, error: nil)
        } catch {
            presenter?.didFinishFetch(items: nil, error: error)
        }
    }
    
    func removeFromWishList(_ item: WishListItem) {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.wishListItem)
        let predicate = NSPredicate(format: "id == %@", item.id ?? "")
        deleteFetch.predicate = predicate
        do {
            let _ = try managedObjectContext.fetch(deleteFetch).map { managedObjectContext.delete($0)}
            CoreDataStack.shared.saveContext()
            presenter?.didWishListDelete()
        } catch {
            print ("There was an error")
        }
    }
}
