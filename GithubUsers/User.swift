//
//  User.swift
//  GithubUsers
//
//  Created by Anton Paliakou on 8/12/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}
