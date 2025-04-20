//
//  CommentViewModel.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation
import FirebaseFirestore



class CommentsViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var newComment: String = ""

    let post: Post

    init(post: Post) {
        self.post = post
        self.comments = post.comments
    }

    func addComment() {
        guard let user = FirebaseService.shared.currentUser,
              !newComment.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let comment = Comment(
            id: UUID().uuidString,
            text: newComment,
            username: user.name,
            userimage: user.image
        )

        comments.append(comment)

        FirebaseService.shared.db.collection("posts").document(post.id).updateData([
            "comments": comments.map { try! Firestore.Encoder().encode($0) }
        ]) { error in
            if let error = error {
                print("Error adding comment:", error)
            }
        }

        newComment = ""
    }
}
