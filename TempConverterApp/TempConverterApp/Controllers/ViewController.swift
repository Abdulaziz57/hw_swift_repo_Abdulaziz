//
//  ViewController.swift
//  TempConverterApp
//
//  Created by Abdulaziz Al Mannai on 27/01/2025.
//

import Foundation

class ViewController: ObservableObject {
    var tempConverter: TempConverter = TempConverter()

    @Published var inputTempString: String = "Temp"
    @Published var convertedTempString = "Temp"
    @Published var isConvertingCtoF: Bool = true

    func setInputTempString(_ temp: String) {
        inputTempString = temp
    }

    
    func setConvertedTempString() {
        if let convertedTemp = tempConverter.getConvertedTemp() {
            convertedTempString = "\(convertedTemp)"
        } else {
            convertedTempString = "N/A"
        }
    }


    func setInputTempUnit() {
        isConvertingCtoF ? tempConverter.setInputUnit(.celsius) :
            tempConverter.setInputUnit(.fahrenheit)
    }

    func convert() {
        setInputTempUnit()
        
        let inputTemp = Int(inputTempString) ?? -500
        tempConverter.setInputTemp(inputTemp)
        tempConverter.convert()
        setConvertedTempString()
    }

}
