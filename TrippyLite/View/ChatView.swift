//
//  ChatView.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(message.sender)
                                            .font(.caption)
                                            .foregroundColor(.gray)

                                        Text(message.text)
                                            .padding(10)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(8)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                }

                HStack {
                    TextField("Type a message...", text: $viewModel.newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: viewModel.sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Chat")
        }
    }
}


#Preview {
    ChatView()
}
