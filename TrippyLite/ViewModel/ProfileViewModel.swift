//
//  ProfileViewModel.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var userimage: String = ""
    @Published var likedCount: Int = 0
    @Published var followingCount: Int = 0
    @Published var isLoading = true

    init() {
        loadProfile()
    }

    func loadProfile() {
        if let user = FirebaseService.shared.currentUser {
            DispatchQueue.main.async {
                self.username = user.name
                self.userimage = user.image
                self.likedCount = user.userLiked.count
                self.followingCount = user.following.count
                self.isLoading = false
            }
        } else {
            print("⚠️ currentUser is nil")
            isLoading = false
        }
    }
}


