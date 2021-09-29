//
//  Constants.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/27.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://60d2fa72858b410017b2ea05.mockapi.io/api/v1/menu"
    }
    
    struct Placeholder {
            static let product = "Placeholder"
    }
    
    struct WishList {
        static let add = "Add To WishList"
        static let remove = "Clear From WishList"
    }
    
    struct Error {
        struct Message {
            static let generic = "Something went wrong"
            static let noData = "Data unavailable"
        }
    }
    
    struct Entity {
        static let productItem = "Product"
        static let wishListItem = "WishListItem"

        struct Keypath {
            static let id = "id"
            static let title = "name"
            static let details = "details"
            static let price = "price"
            static let url = "url"
        }
    }
}
