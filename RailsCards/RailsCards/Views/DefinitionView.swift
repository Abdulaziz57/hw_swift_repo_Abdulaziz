//
//  DefinitionView.swift
//  RailsCards
//
//  Created by Abdulaziz Al Mannai on 02/02/2025.
//

import SwiftUI

struct DefinitionView: View {
    let viewController: ViewController
    
    var body: some View {
        ZStack{
            if let flashcard = viewController.flashcard{
                Text(flashcard.definition)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.all)
            } else {
                Text("Loading flashcards...")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.all)
            }
        }
        .frame(width: 350, height: 200)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color.gray)
            )
    }
}


