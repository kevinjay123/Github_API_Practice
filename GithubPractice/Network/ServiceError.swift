//
//  ServiceError.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation

enum ServiceError: Error {
    case url
    case data
    case other(string: String)
    case authorization(string: String)
    case reachability
    case service(error: Error)
    case cancel

    var title: String {
        switch self {
        case .other:
            return ""
        default:
            return ""
        }
    }
}
