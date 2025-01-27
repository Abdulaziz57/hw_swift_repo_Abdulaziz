//
//  ContentView.swift
//  TempConverterApp
//
//  Created by Abdulaziz Al Mannai on 27/01/2025.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewController = ViewController()
    @State var inputTemp: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.50)
                
                // Adding gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.gray]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
                
                VStack {
                    Spacer()
                    
                    if viewController.isConvertingCtoF {
                        Text("\(viewController.convertedTempString) ºF")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                    } else {
                        Text("\(viewController.convertedTempString) ºC")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                    }
                    
                    Spacer()
                    
                    Text("Enter Temperature:")
                        .fontWeight(.bold)
                    
                    TextField("temperature", text: $inputTemp)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 35.0)
                        .border(Color.white, width: 0.50)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numbersAndPunctuation)
                    
                    Spacer()
                    HStack(alignment: .center) {
                        Text("ºF -> ºC")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Toggle(isOn: $viewController.isConvertingCtoF){
                            Text("")
                        }
                        .labelsHidden()
                        .frame(width: 50)
                        .padding()
                        Text("ºC -> ºF")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }

                    .padding()
                    
                    Button("Convert") {
                        viewController.setInputTempString(self.inputTemp)
                        viewController.convert()
                    }
                    .padding(.all)
                    .background(Color.white)
                    .cornerRadius(15.0)
                    
                    Spacer()
                    
                    NavigationLink(destination: InfoView()) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
    }
}



#Preview {
    ContentView()
}

