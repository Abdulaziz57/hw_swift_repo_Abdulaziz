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
    @Published var isLoading = true

    init() {
        loadProfile()
    }

    func loadProfile() {
        guard let user = FirebaseService.shared.currentUser else {
            return
        }
        DispatchQueue.main.async {
            self.username = user.name
            self.userimage = user.image
            self.isLoading = false
        }
    }
}
