//
//  RepositoriesResponse.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation

struct RepositoryResponse: Codable {
    let totalCount: Int
    let repositories: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositories = "items"
    }
}
