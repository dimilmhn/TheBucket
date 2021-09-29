//
//  ProductService.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/27.
//

import Foundation

struct ProductService: NetworkServiceProtocol {
    var url: String!
    
    init(_ url: String = Constants.API.baseURL) {
        self.url = url
    }
    
    var baseURL: URL? {
        return URL(string: url)
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .json
    }
}
