//
//  AuthorizationProvider.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

final class AuthorizationProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    var session: ASWebAuthenticationSession?
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
    
    @MainActor
    @discardableResult
    func start() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            start {
                continuation.resume(returning: $0)
            }
        }
    }

    
    private func start(callback: ((Bool) -> Void)?) {
        let queryItems = [
          URLQueryItem(name: "client_id", value: "Iv1.42bda26d6fd553b9")
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "github.com"
        urlComponents.path = "/login/oauth/authorize"
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "githubclone") { url, error in
            guard let url else { return }
            
            Task {
                let code = "\(url)".components(separatedBy: "code=").last ?? ""
                
                print(code)
                
                let queryItems = [
                  URLQueryItem(name: "client_id", value: "Iv1.42bda26d6fd553b9"),
                  URLQueryItem(name: "client_secret", value: "e2a2d54674141936d9616fea5101dc8287083517"),
                  URLQueryItem(name: "code", value: code),
                ]
                
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "github.com"
                urlComponents.path = "/login/oauth/access_token"
                urlComponents.queryItems = queryItems
                
                let url = urlComponents.url!
                var request = URLRequest(url: url)
                
                request.httpMethod = "POST"
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let stringData = String(data: data, encoding: .utf8)
                let token = stringData?.slice(from: "access_token=", to: "&") ?? ""
                
                print("access token \(token)")
                guard !token.isEmpty else {
                    callback?(false)
                    return
                }
                
                UserDefaults.standard.set(token, forKey: StorageKeys.token.rawValue)
                callback?(true)
            }
        }
        
        session.presentationContextProvider = self
        session.start()
    }
}
