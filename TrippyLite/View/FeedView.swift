//
//  FeedView.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search...", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding([.horizontal, .top])

                // Posts List
                List {
                    ForEach(viewModel.posts.filter {
                        viewModel.searchText.isEmpty || $0.title.lowercased().contains(viewModel.searchText.lowercased())
                    }) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.headline)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(post.images, id: \.self) { imageUrl in
                                        AsyncImage(url: URL(string: imageUrl)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(10)
                                    }
                                }
                            }

                            HStack {
                                Button(action: {
                                    viewModel.toggleLike(for: post)
                                }) {
                                    Image(systemName: viewModel.isPostLiked(post) ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }

                                Text("\(post.likes) likes")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Spacer()

                                NavigationLink(destination: CommentsView(post: post)) {
                                    Text("Comments")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedView()
}
