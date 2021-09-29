//
//  Task.swift
//  Pokemon
//
//  Created by Dimil T Mohan on 2021/09/26.
//

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
