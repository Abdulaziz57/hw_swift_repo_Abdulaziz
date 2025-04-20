//
//  ChatMessage.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id: String
    var groupName: String
    var sender: String
    var senderId: String
    var text: String
    var image: String
    var timestamp: Date
}
