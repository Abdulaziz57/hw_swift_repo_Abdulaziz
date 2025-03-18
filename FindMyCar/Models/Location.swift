//
//  Location.swift
//  FindMyCar
//
//  Created by Abdulaziz Al Mannai on 18/03/2025.
//

import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    var latitude: Double
    var longitude: Double
    var locationManager = CLLocationManager()

    override init() {
        latitude = 0.0
        longitude = 0.0
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            latitude = loc.coordinate.latitude
            longitude = loc.coordinate.longitude
        }
    }
}

extension String {
    func appendToDocumentDir() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory.appendingPathComponent(self).path
    }
}

extension Location {
    func dataFilePath() -> String {
        return "carLocation.plist".appendToDocumentDir()
    }

    func saveLocation() {
        let dict: [String: Double] = ["latitude": latitude, "longitude": longitude]
        let plistPath = dataFilePath()
        NSDictionary(dictionary: dict).write(toFile: plistPath, atomically: true)
    }

    func loadLocation() {
        let plistPath = dataFilePath()
        if let dict = NSDictionary(contentsOfFile: plistPath) as? [String: Double] {
            latitude = dict["latitude"] ?? 0.0
            longitude = dict["longitude"] ?? 0.0
        }
    }

    func clearCarLocation() {
        latitude = 0.0
        longitude = 0.0
    }
}

