//
//  GithubAPI.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol GithubAPI {
    func fetchUser(name: String, page: String) -> Single<GitHubSearch>
}
