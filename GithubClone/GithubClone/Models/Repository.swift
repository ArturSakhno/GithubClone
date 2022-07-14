//
//  Repository.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation

struct Repository: Codable, Identifiable, Hashable {
    var name: String
    var stars: Int
    var id: Int
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case stars = "stargazers_count"
        case id
        case url = "html_url"
    }
    
    static let mock = Repository(name: "Repository", stars: 123, id: 42, url: "URL")
}
