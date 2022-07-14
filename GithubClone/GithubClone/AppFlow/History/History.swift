//
//  History.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct History: View {
    @StateObject var viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) {
                    RepositoryView(repository: $0)
                }
            }
            .navigationTitle("History")
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
