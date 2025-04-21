//
//  FirebaseService.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()
    private let storage = Storage.storage()
    var currentUserID: String = "abdulazizAlMannai"
    var currentUser: User? = User(
        id: "abdulazizAlMannai",
        name: "Abdulaziz Al Mannai",
        image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F403019%2Favatar_male_man_person_user_young_icon&psig=AOvVaw23VvP1AiN8oUYxKmK0M3ak&ust=1745308486416000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKjPmPXS6IwDFQAAAAAdAAAAABAE",
        following: ["one", "two", "three"],
        userLiked: ["one"]
    )



    // Fetch users
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        db.collection("users").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            let users = docs.compactMap { try? $0.data(as: User.self) }
            completion(users)
        }
    }

    // Create post
    func createPost(post: Post, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection("posts").addDocument(from: post)
            completion(true)
        } catch {
            print("Error creating post:", error)
            completion(false)
        }
    }

    // Fetch posts
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        db.collection("posts").addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                print("⚠️ No snapshot data")
                return
            }

            let posts: [Post] = docs.compactMap {
                do {
                    return try $0.data(as: Post.self)
                } catch {
                    print("⚠️ Error decoding post:", error)
                    return nil
                }
            }

            completion(posts)
        }
    }


    // Like a post
    func likePost(postID: String, newLikes: Int) {
        db.collection("posts").document(postID).updateData([
            "likes": newLikes
        ])
    }

    // Chat service: send message
    func sendMessage(message: ChatMessage, groupId: String) {
        do {
            _ = try db.collection("chats").document(groupId)
                .collection("messages")
                .addDocument(from: message)
        } catch {
            print("Error sending message:", error)
        }
    }

    // Fetch chat messages
    func fetchMessages(groupId: String, completion: @escaping ([ChatMessage]) -> Void) {
        db.collection("chats").document(groupId)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                let messages = docs.compactMap { try? $0.data(as: ChatMessage.self) }
                completion(messages)
            }
    }
    
    // Add a new post with multiple images
    func addPost(title: String, images: [UIImage], completion: @escaping () -> Void) {
        guard let user = currentUser else { return }

        var imageURLs: [String] = []
        let group = DispatchGroup()

        for image in images {
            group.enter()
            guard let data = image.jpegData(compressionQuality: 0.8) else {
                group.leave()
                continue
            }

            let imageRef = storage.reference().child("posts/\(user.id ?? "unknown")/\(UUID().uuidString).jpg")
            imageRef.putData(data, metadata: nil) { _, _ in
                imageRef.downloadURL { url, _ in
                    if let url = url {
                        imageURLs.append(url.absoluteString)
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            let post = Post(
                id: UUID().uuidString,
                title: title,
                images: imageURLs,
                uid: user.id ?? "",
                likes: 0,
                comments: [],
                username: user.name,
                userimage: user.image
            )

            do {
                try self.db.collection("posts").document(post.id ?? UUID().uuidString).setData(from: post)
                completion()
            } catch {
                print("Failed to add post:", error)
            }
        }
    }
    
    // Update like for a specific post
    func updateLike(for postId: String, isLiked: Bool, completion: @escaping () -> Void) {
        guard let user = currentUser else { return }

        let postRef = db.collection("posts").document(postId)
        postRef.updateData(["likes": FieldValue.increment(Int64(isLiked ? 1 : -1))])

        var updatedLikes = user.userLiked
        if isLiked {
            updatedLikes.append(postId)
        } else {
            updatedLikes.removeAll { $0 == postId }
        }

        db.collection("users").document(user.id ?? "").updateData([
            "userLiked": updatedLikes
        ]) { _ in
            completion()
        }
    }


}
