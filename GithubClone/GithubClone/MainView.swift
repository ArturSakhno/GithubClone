//
//  MainView.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            History()
                .tabItem {
                    Image(systemName: "book.closed")
                }
            
            Profile()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
