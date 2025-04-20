//
//  FeedViewModel.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation
import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        FirebaseService.shared.fetchPosts { [weak self] posts in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
    }

    func toggleLike(for post: Post) {
        let isLiked = !isPostLiked(post)
        FirebaseService.shared.updateLike(for: post.id, isLiked: isLiked) {
            self.fetchPosts()
        }
    }

    func isPostLiked(_ post: Post) -> Bool {
        guard let user = FirebaseService.shared.currentUser else { return false }
        return user.userLiked.contains(post.id)
    }
}
