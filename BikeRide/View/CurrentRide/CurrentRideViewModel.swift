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
    @Published var showSheet = false
    
    @Published var finishedRide = BikeRide()
    @Published var reset = false
    
    
    func startAndEndRide() -> Void {
        isMoving.toggle()
        if isMoving {
            duration.isRunning.toggle()
            locationManager.isRideInProgress = true
            locationManager.startUpdatingLocation()
            reset = false
        } else {
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
    
    func getAverageSpeed() -> Double {
        var speed = 0.0
        if reset {
            locationManager.reset()
        } else {
            speed = locationManager.average_speed()
        }
        return speed
    }
    
    func resetAvgSpeed() -> Void {
        locationManager.avg_speed = 0
    }
    
}
