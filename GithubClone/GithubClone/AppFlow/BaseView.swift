//
//  BaseView.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct BaseView: View {
    @EnvironmentObject var user: AppUser
    
    var body: some View {
        switch user.userState {
        case .splash: Splash()
        case .login: Authorization()
        case .authorized: MainView()
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
