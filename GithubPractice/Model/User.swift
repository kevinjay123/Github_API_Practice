//
//  User.swift
//  GithubPractice
//
//  Created by Kevin Chan on 2021/1/20.
//

import Foundation

struct GitHubSearch: Codable {
    var users: [User] = []
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

struct User: Codable {
    
    var id: Int = 0
    var nodeId: String = ""
    var avatarUrlString: String = ""
    var name: String = ""
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case avatarUrlString = "avatar_url"
        case name = "login"
    }
}
