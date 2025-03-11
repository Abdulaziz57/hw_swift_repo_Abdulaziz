//
//  ViewModel.swift
//  SimpleBrowser
//
//  Created by Abdulaziz Al Mannai on 11/03/2025.
//


import SwiftUI
import Combine

enum WebViewOptions {
    case goBack
    case goForward
    case share
    case refresh
    case stop
}

class ViewModel: ObservableObject {
    @Published var urlString: String = ""
    @Published var shouldShowShareSheet: Bool = false
    var webViewOptionsPublisher = PassthroughSubject<WebViewOptions, Never>()
    
    func goBack() {
        webViewOptionsPublisher.send(.goBack)
    }
    
    func goForward() {
        webViewOptionsPublisher.send(.goForward)
    }
    
    func share() {
        shouldShowShareSheet = true
    }
    
    func refresh() {
        webViewOptionsPublisher.send(.refresh)
    }
    
    func stop() {
        webViewOptionsPublisher.send(.stop)
    }
}

