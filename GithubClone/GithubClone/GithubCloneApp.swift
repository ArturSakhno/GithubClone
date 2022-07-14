//
//  GithubCloneApp.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

@main
struct GithubCloneApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject var user = AppUser()
    
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(user)
        }
    }
}
