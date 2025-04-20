//
//  User.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var image: String
    var following: [String]
    var userLiked: [String]
}

