//
//  TempConverter.swift
//  TempConverterApp
//
//  Created by Abdulaziz Al Mannai on 27/01/2025.
//

import Foundation

import Foundation

class TempConverter {
    enum TemperatureUnit: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }

    var isConvertingCtoF: Bool = true
    var inputTemp: Int = 0
    var convertedTemp: Int?

    func isBelowAbsoluteZero() -> Bool {
        if isConvertingCtoF {
            return inputTemp > -273
        } else {
            return inputTemp > -459
        }
    }

    func setInputUnit(_ tempunit: TemperatureUnit) {
        switch tempunit {
        case .celsius:
            isConvertingCtoF = true
        case .fahrenheit:
            isConvertingCtoF = false
        }
    }

    func setInputTemp(_ temp: Int) {
        inputTemp = temp
    }

    func getConvertedTemp() -> Int? {
        return convertedTemp
    }
    
    private func celsiusToFahrenheit() {
        convertedTemp = Int(Double(inputTemp) * 9.0 / 5.0 + 32.0)
    }

    private func fahrenheitToCelsius() {
        convertedTemp = Int((Double(inputTemp) - 32.0) * (5.0 / 9.0))
    }



    func convert() {
        guard isBelowAbsoluteZero() else {
            convertedTemp = nil
            return
        }

        if isConvertingCtoF {
            celsiusToFahrenheit()
        } else {
            fahrenheitToCelsius()
        }
    }

}

