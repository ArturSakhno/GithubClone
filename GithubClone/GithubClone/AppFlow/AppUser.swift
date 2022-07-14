//
//  AppUser.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import Foundation
import SwiftUI

final class AppUser: ObservableObject {
    private enum Constants {
        static let timeToDisplaySplashScreen = 1.0
    }
    enum UserState: String {
        case splash
        case login
        case authorized
    }
    
    @Published var userState: UserState = .splash
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeToDisplaySplashScreen) {
            self.setupUserState()
        }
    }
    
    func setupUserState() {
        let token: String = ProtectedStorageService.shared.getValue(forKey: StorageKeys.token.rawValue) ?? ""
        userState = token.isEmpty ?
            .login :
            .authorized
    }
}
