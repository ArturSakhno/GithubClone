//
//  Profile.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var user: AppUser
    
    var body: some View {
        List {
            Button("Log Out") {
                user.userState = .login
                UserDefaults.standard.removeObject(forKey: StorageKeys.token.rawValue)
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
