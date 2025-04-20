//
//  PostView.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Post Title", text: $viewModel.title)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                }

                PhotosPicker(
                    selection: $selectedItems,
                    maxSelectionCount: 5,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Select Images")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .onChange(of: selectedItems) { newItems in
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    viewModel.selectedImages.append(image)
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    viewModel.addPost {
                        print("Post uploaded successfully!")
                    }
                }) {
                    if viewModel.isUploading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Upload Post")
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Create Post")
        }
    }
}


#Preview {
    PostView()
}
