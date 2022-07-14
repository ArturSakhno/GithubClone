//
//  AuthorizationViewModel.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import Foundation


final class AuthorizationViewModel: ObservableObject {
    let authProvider = AuthorizationProvider()
    
    @Published var authorized = false
    
    @MainActor
    func start() {
        Task {
            do {
               try await authProvider.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.authorized = true
                }
            } catch {
                
            }
            
            print("Artur \(authorized)")
        }
    }
}


