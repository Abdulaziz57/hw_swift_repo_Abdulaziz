//
//  BookRow.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import SwiftUI


struct BookRowView: View {
    var book: Book

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title).font(.headline)
            Text(book.author).font(.subheadline)
        }
    }
}



