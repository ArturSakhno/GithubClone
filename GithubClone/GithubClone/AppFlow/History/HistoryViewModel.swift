//
//  HistoryViewModel.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    
    func onAppear() {
        repositories = StorageService.shared.getRepositories()
    }
}
