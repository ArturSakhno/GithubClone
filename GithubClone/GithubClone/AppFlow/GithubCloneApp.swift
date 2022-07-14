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
    @ObservedObject var storage = StorageService()
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(user)
                .environment(\.managedObjectContext, storage.container.viewContext)
        }
    }
    
    private func registerDependencies() {
        DIContainer.shared.register(type: SearchServiceInterface.self, component: SearchService())
        DIContainer.shared.register(type: NetworkInterface.self, component: Network())
    }
}
