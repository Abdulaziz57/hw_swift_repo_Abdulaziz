//
//  Book.swift
//  BookManager
//
//  Created by Abdulaziz Al Mannai on 10/02/2025.
//

import Foundation

import SwiftUI

struct Book: Identifiable, Comparable {
    public var id = UUID()
    var title: String
    var author: String
    var gender: Gender
    var displayed: Bool

    init(title: String, author: String, gender: Gender, displayed: Bool = true) {
        self.title = title
        self.author = author
        self.gender = gender
        self.displayed = displayed
    }
    
    public static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.author == rhs.author
    }

    public static func < (lhs: Book, rhs: Book) -> Bool {
        lhs.title < rhs.title
    }
}
