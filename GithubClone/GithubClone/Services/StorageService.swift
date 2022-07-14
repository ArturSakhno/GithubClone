//
//  StorageService.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation
import CoreData

class StorageService: ObservableObject {
    let container = NSPersistentContainer(name: "GithubClone")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}



