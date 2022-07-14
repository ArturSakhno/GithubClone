//
//  RequestError.swift
//  IMDB
//
//  Created by Artur Sakhno on 16.06.2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No Response"
        case .unexpectedStatusCode:
            return "Unexpected Status Code"
        default:
            return "Unknown error"
        }
    }
}
