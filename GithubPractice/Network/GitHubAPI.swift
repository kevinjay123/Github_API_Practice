//
//  GithubAPI.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import RxCocoa
import RxSwift

protocol GitHubAPI {
    func fetchUser(name: String, page: String) -> Single<GitHubSearch>
}
