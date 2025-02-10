//
//  LibraryView.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import SwiftUI


struct LibraryView: View {
    @EnvironmentObject var library: Library

    var body: some View {
        NavigationView {
            List {
                ForEach(library.books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRowView(book: book)
                    }
                }
                .onDelete(perform: removeRows)
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        library.books.remove(atOffsets: offsets)
    }
}

#Preview {
    LibraryView().environmentObject(Library())
}
