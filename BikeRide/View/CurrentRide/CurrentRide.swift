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
            VStack(alignment: .leading) {
                
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("TIME")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text("\(ride_duration.formattedDuration(from: TimeInterval(ride_duration.initial)))").onReceive(ride_duration.timer){ _ in ride_duration.beginTime()}
                                .font(.system(size: 35, weight: .bold))
                                .bold()
                                .foregroundColor(Color(UIColor.label))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("AVG. SPEED")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text("\(ride_distance.average_speed())")
                                .font(.system(size: 35, weight: .bold))
                                .bold()
                                .foregroundColor(Color(UIColor.label))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("DISTANCE")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                            Text(String(format: "%.2f miles", ride_distance.totalDistance))
                                .font(.system(size: 55, weight: .bold))
                                .bold()
                                .foregroundColor(Color(UIColor.label))
                        }
                    }
                
                
                Spacer()
                
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
                        rideOver = BikeRide(
                            duration_of_ride: ride_duration.initial,
                            location_of_rider: ride_distance.totalDistance,
                            locations: ride_distance.convertCllocation(locationList: ride_distance.allLocations),
                            endingLocation: MKCoordinateRegion(
                                center: ride_distance.convertCllocation(locationList: ride_distance.allLocations).last ?? CLLocationCoordinate2D(latitude: 120, longitude: -12),
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    }
                })  {
                    Text(isMoving ? "PAUSE" : "START")
                        .font(.largeTitle)
                        .bold()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .background(Color(UIColor.label))
                }
            }
        }.sheet(isPresented: $showSheet){
            PostRidesView(rideOver: $rideOver)
                .presentationDragIndicator(.visible)
        }
        .padding(40)
        .onDisappear {
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
