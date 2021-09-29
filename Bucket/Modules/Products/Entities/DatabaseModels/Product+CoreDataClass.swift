//
//  Product+CoreDataClass.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .title)
            try container.encode(price, forKey: .price)
            try container.encode(details, forKey: .description)
            try container.encode(url, forKey: .imageURL)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        print(decoder.userInfo)
        print(decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext)
        print(NSEntityDescription.entity(forEntityName: Constants.Entity.productItem, in: (decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext)!)!)
        guard let contextUserInfoKey = CodingUserInfoKey.context,
        let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.productItem, in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try values.decode(String.self, forKey: .id)
            name = try values.decode(String.self, forKey: .title)
            url = try values.decode(String.self, forKey: .imageURL)
            price = try values.decode(String.self, forKey: .price)
            details = try values.decode(String.self, forKey: .description)

        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case price
        case description
        case imageURL = "image"
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
