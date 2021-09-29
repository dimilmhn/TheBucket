//
//  Decode+Extension.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/27.
//

import Foundation
import UIKit

extension KeyedDecodingContainer {
    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
        where T : Decodable {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
}
