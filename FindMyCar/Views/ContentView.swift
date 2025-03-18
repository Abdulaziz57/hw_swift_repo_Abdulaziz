//
//  ContentView.swift
//  FindMyCar
//
//  Created by Abdulaziz Al Mannai on 18/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var viewController = ViewController()
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                Button(action: {
                    viewController.getCurrentLocation()
                    viewController.saveCarLocation()
                    showingAlert = true
                }) {
                    Text("Here's My Car")
                    .padding(.top, 150)

                }
                
                .padding(.bottom, 200)
                
                NavigationLink(destination: MapView(viewController: viewController)) {
                    Text("Where's My Car?")
                }
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Car Saved"), message: Text(viewController.getCarLocationMessage()), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
