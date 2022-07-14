//
//  Authorization.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI
import AuthenticationServices

struct Authorization: View {
    @StateObject var viewModel = AuthorizationViewModel()
    @EnvironmentObject var appUser: AppUser
    
    var body: some View {
        VStack {
            Button {
                viewModel.start()
            } label: {
                Text("Login with GitHub")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(.blue)
                    .cornerRadius(10)
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
