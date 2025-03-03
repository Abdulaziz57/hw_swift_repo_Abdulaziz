//
//  AppView.swift
//  SimpleContacts
//
//  Created by Abdulaziz Al Mannai on 03/03/2025.
//

import SwiftUI


struct AppView: View {
    @State private var isDatabaseInitialized = false
    
    private func initializeDatabase() async {
        if !isDatabaseInitialized {
            await PersonService.shared.initializeDatabase()
            isDatabaseInitialized = true
        }
    }
    
    var body: some View {
        NavigationStack {
            PeopleView()
                .navigationTitle("My Contacts")
                .onAppear {
                    Task {
                        await initializeDatabase()
                    }
                }
        }
    }
}

#Preview {
    AppView()
}
