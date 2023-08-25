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
        ZStack {
            MapView(region: rideOver.endingLocation, lineCoordinates: rideOver.locations).ignoresSafeArea()
            HStack {
                Text("\(rideOver.duration_of_ride)").font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    )
                Text("\(rideOver.location_of_rider)").font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    )
            }
            
        }
    }
}

struct PostRidesView_Previews: PreviewProvider {
    static var previews: some View {
        PastRidesView()
    }
}
