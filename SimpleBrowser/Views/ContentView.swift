//
//  ContentView.swift
//  SimpleBrowser
//
//  Created by Abdulaziz Al Mannai on 11/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            SearchBar(viewModel: viewModel)
            WebView(viewModel: viewModel)
            BottomBar(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldShowShareSheet) {
            let urlString = viewModel.urlString.starts(with: "http") ? viewModel.urlString : "https://\(viewModel.urlString)"
            if let url = URL(string: urlString) {
                ShareSheet(items: [url])
            } else {
                Text("Invalid URL")
            }
        }
    }
}


#Preview {
    ContentView()
}
