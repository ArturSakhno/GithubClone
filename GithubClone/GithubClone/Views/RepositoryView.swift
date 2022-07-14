//
//  RepositoryView.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import SwiftUI

struct RepositoryView: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
            Text(repository.url)
            Text("\(repository.stars)")
                .font(.caption2)
        }
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repository: Repository.mock)
    }
}
