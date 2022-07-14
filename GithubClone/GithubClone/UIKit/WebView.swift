//
//  WebView.swift
//  GithubClone
//
//  Created by Artur Sakhno on 14.07.2022.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    var url: String
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
