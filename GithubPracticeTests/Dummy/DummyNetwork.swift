//
//  DummyNetwork.swift
//  GithubPracticeTests
//
//  Created by Kevin Chan on 2021/1/21.
//

import Foundation
import RxSwift
import RxCocoa

@testable import GithubPractice

class DummyNetwork: GithubAPI {
    func fetchUser(name: String, page: String) -> Single<GitHubSearch> {
        return Single.create { (single) -> Disposable in
            
            if !name.isEmpty, let pageCount = Int(page) {
                
                var search = GitHubSearch()
                var user = User()
                
                if pageCount > 1 {
                    user.avatarUrlString = "www.apple.com"
                    user.name = "Tim"
                    user.id = 2
                    user.nodeId = "Test2"
                    search.users.append(user)
                    
                    user.avatarUrlString = "www.youtube.com"
                    user.name = "Lu"
                    user.id = 3
                    user.nodeId = "Test3"
                    search.users.append(user)
                    
                } else {
                    user.avatarUrlString = "www.google.com"
                    user.name = "Kevin"
                    user.id = 1
                    user.nodeId = "Test1"
                    search.users = [user]
                }

                single(.success(search))
            } else {
                single(.error(ServiceError.data))
            }
            
            return Disposables.create()
        }
    }
}
