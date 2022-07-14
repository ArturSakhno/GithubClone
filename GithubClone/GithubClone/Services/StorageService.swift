//
//  StorageService.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation
import CoreData

final class StorageService: ObservableObject {
    static let shared = StorageService()
    
    private let container = NSPersistentContainer(name: "GithubClone")
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            context.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getRepositories() -> [Repository] {
        let request: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
        
        do {
            return try context.fetch(request).map({
                Repository(name: $0.name ?? "",
                           stars: Int($0.stars),
                           id: Int($0.id),
                           url: $0.url ?? "")
            })
        } catch {
            return []
        }
    }
    
}



