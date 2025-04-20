//
//  ChatViewModel.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation


class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessage: String = ""
    @Published var isLoading = true

    private let groupName = "general"

    init() {
        listenToMessages()
    }

    func listenToMessages() {
        FirebaseService.shared.fetchMessages(groupId: groupName) { [weak self] messages in
            DispatchQueue.main.async {
                self?.messages = messages
                self?.isLoading = false
            }
        }
    }

    func sendMessage() {
        guard let user = FirebaseService.shared.currentUser,
              !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let message = ChatMessage(
            id: UUID().uuidString,
            groupName: groupName,
            sender: user.name,
            senderId: user.id ?? "",
            text: newMessage,
            image: "",
            timestamp: Date()
        )

        FirebaseService.shared.sendMessage(message: message, groupId: groupName)
        newMessage = ""
    }
}
