//
//  Product+CoreDataProperties.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var price: String?
    @NSManaged public var url: String?

}

extension Product : Identifiable {

}
