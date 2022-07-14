//
//  SearchService.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation

protocol SearchServiceInterface {
    func searchRepositories(query: String) async -> [Repository]
    func loadMoreRepositories(query: String) async -> [Repository]
}

final class SearchService: SearchServiceInterface {
    private var currentPage = 1
    private let perPage = 20

    private var network: NetworkInterface {
        return DIContainer.shared.resolve(type: NetworkInterface.self)
    }
    
    func searchRepositories(query: String) async -> [Repository] {
        currentPage = 1
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return [] }
        
        let queryItems = [
          URLQueryItem(name: "q", value: query),
          URLQueryItem(name: "sort", value: "stars"),
          URLQueryItem(name: "per_page", value: "30")
        ]
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return [] }
        
        let request = URLRequest(url: url)
        
        let response = await network.sendRequest(request: request, responseModel: RepositoryResponse.self)
        switch response {
        case .success(let response):
            return response.repositories
        case .failure(let error):
            print(error)
        }
        
        return []
    }
    
    func loadMoreRepositories(query: String) async -> [Repository] {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return [] }
        currentPage += 1
        
        let queryItems = [
          URLQueryItem(name: "q", value: query),
          URLQueryItem(name: "sort", value: "stars"),
          URLQueryItem(name: "per_page", value: "30"),
          URLQueryItem(name: "page", value: "\(currentPage)")
        ]
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return [] }
        
        let request = URLRequest(url: url)
        
        let response = await network.sendRequest(request: request, responseModel: RepositoryResponse.self)
        switch response {
        case .success(let response):
            return response.repositories
        case .failure(let error):
            print(error)
        }
        
        return []
    }
}
