//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct PostRidesView: View {
    @Binding var rideOver: BikeRide
    @State private var region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965),
      span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 2.0)
    )
    
    
    var body: some View {
        VStack {
            Text("\(rideOver.duration_of_ride)")
            Text("\(rideOver.location_of_rider)")
            MapView(region: rideOver.endingLocation, lineCoordinates: rideOver.locations)
                    }
        }
    }

struct PostRidesView_Previews: PreviewProvider {
    static var previews: some View {
        PastRidesView()
    }
}
