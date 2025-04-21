//
//  ProfileView.swift
//  TrippyLite
//
//  Created by Abdulaziz Al Mannai on 20/04/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let url = URL(string: viewModel.userimage) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                }


                    Text(viewModel.username)
                        .font(.title2)
                        .fontWeight(.semibold)

                    HStack(spacing: 40) {
                        VStack {
                            Text("\(viewModel.likedCount)")
                                .font(.headline)
                            Text("Liked Posts")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        VStack {
                            Text("\(viewModel.followingCount)")
                                .font(.headline)
                            Text("Following")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 8)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
}



#Preview {
    ProfileView()
}
