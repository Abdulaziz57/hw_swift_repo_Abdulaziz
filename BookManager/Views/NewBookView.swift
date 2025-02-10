//
//  NewBookView.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import SwiftUI

struct NewBookView: View {
    @EnvironmentObject var library: Library
    
    @State private var title = ""
    @State private var author = ""
    @State private var gender = "Male"
    @State private var displayed = false

    var body: some View {
        
        
        VStack {
            Text("New Book")
                .font(.title)
                .fontWeight(.bold)
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Picker(selection: $gender,
                       label: Text("Author Gender")) {
                    ForEach(Gender.allGenders, id: \.self) {gender in Text(gender).tag(gender)}
                }
                Toggle(isOn: $displayed
                       , label: {Text("Display book in library")})
                Button("Add Book") {
                    if let genderEnum = Gender(rawValue: gender) {
                        library.addBook(title: title, author: author, gender: genderEnum, displayed: displayed)
                    }
                }
                .fontWeight(.bold)

            }
        }
        .padding()
    }
}


#Preview {
    NewBookView()
}
