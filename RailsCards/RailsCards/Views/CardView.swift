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
                    Text("Show Definition")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .onAppear {
                viewController.updateFlashcard()
            }
        }
    }
}


#Preview {
    CardView()
}
