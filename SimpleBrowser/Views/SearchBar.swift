//
//  SearchBar.swift
//  SimpleBrowser
//
//  Created by Abdulaziz Al Mannai on 11/03/2025.
//

import SwiftUI


struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            Text("URL:")
            TextField("Enter URL...", text: $viewModel.urlString)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

