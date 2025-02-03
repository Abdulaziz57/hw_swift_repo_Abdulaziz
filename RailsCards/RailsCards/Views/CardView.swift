//
//  ContentView.swift
//  RailsCards
//
//  Created by Abdulaziz Al Mannai on 02/02/2025.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewController = ViewController()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink(destination: DefinitionView(viewController: viewController)) {
                    if let flashcard = viewController.flashcard{
                        Text(flashcard.command)
                    } else {
                        Text("Loading flashcards...")
                    }
                }
            }
            .frame(width: 350, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
                )
            .onAppear {
                self.viewController.updateFlashcard()
            }
        }
    }
}


#Preview {
    CardView()
}
