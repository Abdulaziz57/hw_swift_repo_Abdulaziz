//
//  CommentsView.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import SwiftUI

struct CommentsView: View {
    @StateObject private var viewModel: CommentsViewModel

    init(post: Post) {
        _viewModel = StateObject(wrappedValue: CommentsViewModel(post: post))
    }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.comments) { comment in
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: comment.userimage)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(comment.username)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(comment.text)
                                .font(.body)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            HStack {
                TextField("Add a comment...", text: $viewModel.newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: viewModel.addComment) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle("Comments")
    }
}


