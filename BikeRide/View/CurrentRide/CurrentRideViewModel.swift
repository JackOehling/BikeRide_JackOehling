//
//  CurrentRideViewModel.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/25/23.
//

import SwiftUI
import CoreLocation
import MapKit

class CurrentRideViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var duration = Duration()
    @Published var isMoving: Bool = false
    @Published var finishedRide = BikeRide(duration_of_ride: "0", location_of_rider: 0.0, locations: [], endingLocation: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), average_speed: 0.0)
    @Published var showSheet = false
    
    
    // ask if i should move some of my funcs into this class instead of in the models
    func startAndEndRide() -> Void {
        isMoving.toggle()
        if isMoving {
            duration.isRunning.toggle()
            locationManager.isRideInProgress = true
            locationManager.startUpdatingLocation()
            locationManager.distance_in_miles = 0
            locationManager.totalDistance = 0
        } else {
            
            // fix the sheet toggling
            // potentially could change the sheet type to just another screen
            showSheet.toggle()
            duration.isRunning.toggle()
            locationManager.isRideInProgress = false
            locationManager.stopUpdatingLocation()
            finishedRide = BikeRide(
                duration_of_ride: duration.formattedDuration(from: TimeInterval(duration.initial)),
                location_of_rider: locationManager.totalDistance,
                locations: locationManager.convertCllocation(locationList: locationManager.allLocations),
                endingLocation: MKCoordinateRegion(
                    center: locationManager.convertCllocation(locationList: locationManager.allLocations).last ?? CLLocationCoordinate2D(latitude: 120, longitude: -12),
                    span: MKCoordinateSpan(latitudeDelta: locationManager.latitude, longitudeDelta: locationManager.longitude)
                ), average_speed: locationManager.average_speed())
        }
    }
    
    
}
