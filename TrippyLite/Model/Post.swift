//
//  Post.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: String
    var title: String
    var images: [String]
    var uid: String
    var likes: Int
    var comments: [Comment]
    var username: String
    var userimage: String
}
