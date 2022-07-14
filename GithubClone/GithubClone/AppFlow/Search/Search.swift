//
//  Search.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct Search: View {
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    RepositoryView(repository: repository)
                        .listRowBackground(viewModel.viewedRepositories.contains(repository) ? Color.gray : Color.white)
                        .onTapGesture {
                            viewModel.send(event: .onCellTap(repository))
                        }
                        .sheet(isPresented: $viewModel.showWebView) {
                            WebView(url: viewModel.selectedRepository.url)
                        }
                        
                }
                if !viewModel.repositories.isEmpty {
                    Text("Loading next page")
                        .font(.caption2)
                        .onAppear {
                            viewModel.send(event: .loadNextPage)
                        }
                }
            }
            .searchable(text: $viewModel.query)
            .navigationTitle("Search")
        }
        .onChange(of: viewModel.query) { _ in
            viewModel.send(event: .onSearchChange)
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
