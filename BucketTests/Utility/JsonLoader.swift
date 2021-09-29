//
//  JsonLoader.swift
//  BucketTests
//
//  Created by Dimil T Mohan on 2021/09/29.
//

import Foundation

class JsonLoader {
    class func data(withResource resource: String) -> Data? {
        let bundle = Bundle(for: JsonLoader.self)
        if let filePath = bundle.path(forResource: resource, ofType: "json") {
            do {
                let fileContents = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                return fileContents.data(using: String.Encoding.utf8)
            } catch let error as NSError {
                print("Unable to load file contents for \(resource),\n\(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
}
