//
//  AppView.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import SwiftUI


struct AppView: View {
    var library = Library()

    var body: some View {
        TabView {
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }

            NewBookView()
                .tabItem {
                    Label("New Book", systemImage: "rectangle.stack.badge.plus")
                }

            ChartsView()
                .tabItem {
                    Label("Charts", systemImage: "chart.bar.xaxis")
                }
        }
        .environmentObject(library)
    }
}



#Preview {
    AppView()
}
