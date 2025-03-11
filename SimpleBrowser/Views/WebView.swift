//
//  WebView.swift
//  SimpleBrowser
//
//  Created by Abdulaziz Al Mannai on 11/03/2025.
//

import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel
    let webView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var cancellable: AnyCancellable?

        init(_ parent: WebView) {
            self.parent = parent
            super.init()
            
            cancellable = parent.viewModel.webViewOptionsPublisher.sink { option in
                switch option {
                case .goBack:
                    parent.webView.goBack()
                case .goForward:
                    parent.webView.goForward()
                case .refresh:
                    parent.webView.reload()
                case .stop:
                    parent.webView.stopLoading()
                case .share:
                    parent.viewModel.shouldShowShareSheet = true
                }
            }
        }

        deinit {
            cancellable?.cancel()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        var urlString = viewModel.urlString
        if !urlString.starts(with: "http") {
            urlString = "https://\(urlString)"
        }
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}

