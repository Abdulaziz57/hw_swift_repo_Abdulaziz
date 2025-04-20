//
//  PostViewModel.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import Foundation

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isUploading: Bool = false

    func addPost(completion: @escaping () -> Void) {
        guard !title.isEmpty, !selectedImages.isEmpty else { return }
        isUploading = true

        FirebaseService.shared.addPost(title: title, images: selectedImages) {
            DispatchQueue.main.async {
                self.title = ""
                self.selectedImages = []
                self.isUploading = false
                completion()
            }
        }
    }
}
