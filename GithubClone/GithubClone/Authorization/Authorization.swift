//
//  Authorization.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI
import AuthenticationServices

struct Authorization: View {
    @State var showWebView = false
    @StateObject var viewModel = AuthorizationViewModel()
    @EnvironmentObject var appUser: AppUser
    
    var body: some View {
        VStack {
            Button {
                viewModel.start()
            } label: {
                Text("Auth")
            }
        }
        .onChange(of: viewModel.authorized) { authorized in
            appUser.userState = authorized ? .authorized : .login
        }
    }
}

struct Authorization_Previews: PreviewProvider {
    static var previews: some View {
        Authorization()
    }
}
