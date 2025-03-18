//
//  MapView.swift
//  FindMyCar
//
//  Created by Abdulaziz Al Mannai on 18/03/2025.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var viewController: ViewController
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true

        let coordinate = CLLocationCoordinate2D(latitude: viewController.userLocation.latitude, longitude: viewController.userLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

        let droppedPin = MKPointAnnotation()
        droppedPin.coordinate = coordinate
        droppedPin.title = "You are here"
        mapView.addAnnotation(droppedPin)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showsUserLocation = true
    }
}

