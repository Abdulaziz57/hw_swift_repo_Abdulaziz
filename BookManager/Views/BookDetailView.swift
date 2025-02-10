//
//  BookDetail.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding([.top], 40)
            Text(book.author)
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(5)
            Text("Gender: \(book.gender.rawValue)")
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.secondary)
                .padding(20)
        }
        .navigationBarTitle(Text("Book Details"), displayMode: .inline)
        Spacer()
    }
}

