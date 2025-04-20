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
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let url = URL(string: viewModel.userimage) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    }

                    Text(viewModel.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}


#Preview {
    ProfileView()
}
