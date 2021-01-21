//
//  Router.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import Moya

enum Router {
    case user(name: String, page: String)
}

extension Router: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var method: Moya.Method {
        return .get
    }

    var path: String {
        switch self {
        case .user:
            return "/search/users"
        }
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]

        switch self {
        case let .user(name, page):
            params["q"] = name
            params["page"] = page
            return params
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
}
