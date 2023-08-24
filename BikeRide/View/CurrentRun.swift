//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import MapKit

struct CurrentRunView: View {
    @State var isHomeViewable: Bool = true
    @State var isBeginRideViewable: Bool = true
    @State var isEndRideViewable: Bool = false
    
    
    @Binding var isActive: Bool
    @State var ride_duration = Duration()
    @ObservedObject var ride_distance = LocationManager()
    @State var isMoving: Bool = false
    @State var showSheet: Bool = false
    
    @State var rideOver = BikeRide(duration_of_ride: 0, location_of_rider: 0.0, locations: [], endingLocation: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Text("Time: \(ride_duration.initial)").onReceive(ride_duration.timer){ _ in ride_duration.beginTime()}
                
                Text(String(format: "%.2f miles", ride_distance.totalDistance))
            
                
                HStack {
                    if (isBeginRideViewable) {
                        Button(action: {
                            isMoving.toggle()
                            if isMoving {
                                ride_duration.isRunning.toggle()
                                ride_distance.isRideInProgress = true
                                ride_distance.startUpdatingLocation()
                                ride_distance.distance_in_miles = 0
                                ride_distance.totalDistance = 0
                            } else {
                                showSheet.toggle()
                                ride_duration.isRunning.toggle()
                                ride_distance.isRideInProgress = false
                                ride_distance.stopUpdatingLocation()
                                rideOver = BikeRide(duration_of_ride: ride_duration.initial, location_of_rider: ride_distance.totalDistance,
                                                    locations: ride_distance.convertCllocation(locationList: ride_distance.allLocations), endingLocation: MKCoordinateRegion(
                                                        center: ride_distance.convertCllocation(locationList: ride_distance.allLocations).last ?? CLLocationCoordinate2D(latitude: 120, longitude: -12),
                                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                                      )
                                )
                            }
                        })  {
                            Text(isMoving ? "Stop Ride" : "Start Ride")
                                .padding()
                                .cornerRadius(10)
                        }
                    }
                }
            }.buttonStyle(.bordered)
        }.sheet(isPresented: $showSheet){
            PostRidesView(rideOver: $rideOver)
        }
        .onDisappear {
            // Reset ride status, distance, and last known location when leaving the view
            ride_distance.isRideInProgress = false
            ride_distance.totalDistance = 0
            ride_distance.lastLocation = nil
        }
    }
}

struct CurrentRun_Previews: PreviewProvider {
    static var previews: some View {
        CurrentRunView(isActive: .constant(true))
    }
}
