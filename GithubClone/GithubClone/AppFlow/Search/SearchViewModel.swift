//
//  SearchViewModel.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import Foundation
import Combine
import CoreData

final class SearchViewModel: ObservableObject {
    enum Event {
        case searchRepositories
        case onCellTap(Repository)
        case onSearchChange
        case loadNextPage
    }
    private enum Constants {
        static let debounceTimeDelay = 0.5
    }
    
    @Published var repositories: [Repository] = []
    @Published var query = ""
    @Published var showWebView = false
    @Published var selectedRepository = Repository.mock
    @Published var viewedRepositories: [Repository] = []
    
    private var store = Set<AnyCancellable>()
    private let input: PassthroughSubject = PassthroughSubject<Event, Never>()
    
    private let container = DIContainer.shared
    private var searchService: SearchServiceInterface {
        container.resolve(type: SearchServiceInterface.self)
    }
    
    private var debounce: DispatchWorkItem?
    
    init() {
        bind()
    }
    
    func send(event: Event) {
        input.send(event)
    }
    
    private func bind() {
        input
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .searchRepositories:
                    Task {
                        await self.searchRepositories()
                    }
                case .onCellTap(let repository):
                    self.onCellTap(repository: repository)
                case .onSearchChange:
                    self.onSearchChange()
                case .loadNextPage:
                    Task {
                        await self.loadNextPage()
                    }
                }
            }
            .store(in: &store)
    }
    
    @MainActor
    private func searchRepositories() async {
        guard !query.isEmpty else {
            repositories = []
            return
        }
        repositories = await searchService.searchRepositories(query: query)
        viewedRepositories = StorageService.shared.getRepositories()
    }
    
    private func onCellTap(repository: Repository) {
        selectedRepository = repository
        showWebView.toggle()
        save(repository: repository)
        viewedRepositories.append(repository)
    }
    
    private func save(repository: Repository) {
        let repositoryEntity = RepositoryEntity(context: StorageService.shared.context)
        repositoryEntity.id = Int64(repository.id)
        repositoryEntity.name = repository.name
        repositoryEntity.url = repository.url
        repositoryEntity.stars = Int64(repository.stars)
        StorageService.shared.save()
    }
    
    private func onSearchChange() {
        debounce?.cancel()
        
        debounce = DispatchWorkItem(block: { [weak self] in
            guard let self else { return }
            self.send(event: .searchRepositories)
        })
        
        guard let debounce else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.debounceTimeDelay, execute: debounce)
    }
    
    @MainActor
    private func loadNextPage() async {
        let nextPageRepositories = await searchService.loadMoreRepositories(query: query)
        repositories.append(contentsOf: nextPageRepositories)
    }
}
