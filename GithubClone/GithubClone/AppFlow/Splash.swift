//
//  Splash.swift
//  GithubClone
//
//  Created by Artur Sakhno on 12.07.2022.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        Text("SPLASH")
    }
//    @State private var show = false
//    @Namespace private var animation
//
//    var logo: some View {
//        ZStack {
//            Rectangle().frame(width: 600, height: 100)
//                .matchedGeometryEffect(id: "rect", in: animation)
//                .offset(x: -200)
//                .foregroundColor(.white)
//
//            ImageTheme.Splash.logo
//                .matchedGeometryEffect(id: "logo", in: animation)
//                .zIndex(2)
//        }
//        .frame(width: 200, height: 100)
//    }
//
//    var text: some View {
//        ImageTheme.Splash.text
//            .matchedGeometryEffect(id: "text", in: animation)
//            .zIndex(-1)
//    }
//
//    var body: some View {
//        Group {
//            if show {
//                HStack {
//                    logo
//                    text
//                }
//                .transition(.scale(scale: 1))
//            } else {
//                ZStack {
//                    text
//                        .offset(x: -250)
//                    logo
//                }
//            }
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                withAnimation(.easeIn(duration: 2.0)) {
//                    show.toggle()
//                }
//            }
//        }
//    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}

