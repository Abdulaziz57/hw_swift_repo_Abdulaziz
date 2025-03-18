//
//  ViewController.swift
//  FindMyCar
//
//  Created by Abdulaziz Al Mannai on 18/03/2025.
//

import Foundation

class ViewController {
    var userLocation = Location()
    var carLocation = Location()

    func getCurrentLocation() {
        userLocation.getCurrentLocation()
    }

    func saveCarLocation() {
        carLocation.latitude = userLocation.latitude
        carLocation.longitude = userLocation.longitude
    }

    func getCarLocationMessage() -> String {
        return "Car location saved at: \(carLocation.latitude), \(carLocation.longitude)"
    }
}
