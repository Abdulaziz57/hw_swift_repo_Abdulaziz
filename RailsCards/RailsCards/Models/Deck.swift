//
//  Deck.swift
//  RailsCards
//
//  Created by Abdulaziz Al Mannai on 02/02/2025.
//

import Foundation

class Deck {
    var cards: [Flashcard] = []
    var urlString = "https://jsonapis.onrender.com/api/commands"

    func fetchFlashcards() async {
        print("We are accessing the URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from \(urlString)")
            return
        }
        
        do {
            // Fetch data asynchronously from the API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the JSON response into a dictionary [String: String]
            guard let flashcardsArray = try? JSONDecoder().decode([String: String].self, from: data) else {
                print("Could not convert data to dictionary")
                return
            }
            
            let flashcards = flashcardsArray.map { Flashcard(command: $0.key, definition: $0.value) }
            
            // Store the flashcards in the cards array
            self.cards = flashcards
            print("Successfully fetched \(cards.count) flashcards.")
            
        } catch {
            print("Error: Failed to fetch data and response from the URL \(urlString)")
        }
    }
    
    func drawRandomCard() -> Flashcard? {
        guard !cards.isEmpty else {
            print("No flash cards available. Returning nil")
            return Flashcard(command: "", definition: "")
        }
        return cards [Int(arc4random_uniform(UInt32(cards.count)))]
    }
}
