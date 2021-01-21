//
//  Network.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Alamofire
import MapKit
import Moya
import RxSwift
import UIKit

struct Network: GitHubAPI {
    private func request<Element: Codable>(by router: Router) -> Single<Element> {
        return Single.create { (single) -> Disposable in
            let provider = MoyaProvider<Router>()
            provider.request(router) { result in
                switch result {
                case let .success(response):
                    do {
                        let decoder = JSONDecoder()
                        let item = try decoder.decode(Element.self, from: response.data)
                        single(.success(item))
                    } catch {
                        single(.error(error))
                    }

                case let .failure(error):
                    single(.error(error))
                }
            }

            return Disposables.create()
        }
    }
}

extension Network {
    func fetchUser(name: String, page: String) -> Single<GitHubSearch> {
        return request(by: Router.user(name: name, page: page))
    }
}
