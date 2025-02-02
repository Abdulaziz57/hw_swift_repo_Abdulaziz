//
//  ViewController.swift
//  RailsCards
//
//  Created by Abdulaziz Al Mannai on 02/02/2025.
//

import Foundation

class ViewController: ObservableObject {
    let deck = Deck()
    @Published var flashcard: Flashcard?

    init() {
        Task {
            await deck.fetchFlashcards()
            flashcard = deck.drawRandomCard()
        }
    }

    func updateFlashcard() {
        flashcard = deck.drawRandomCard()
    }
}
