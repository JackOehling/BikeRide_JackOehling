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
    var rideOver: BikeRide
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 2.0)
    )
    @State private var fullScreen = false
    @Binding var navigationPath: NavigationPath
    
    
    var body: some View {
        if fullScreen {
            ZStack(alignment: .trailing) {
                MapView(region: rideOver.endingLocation, lineCoordinates: rideOver.locations)
                VStack(alignment: .leading){
                    Button(action: {
                        fullScreen = false
                    }) {
                        Image(systemName: "arrow.down.right.and.arrow.up.left")
                            .padding(15)
                            .foregroundColor(.white)
                            .background {
                                Circle()
                                    .foregroundColor(.black)
                            }
                    }.foregroundColor(.gray)
                        .padding(.all, 10)
                    Spacer()
                }
                
            }
            
        }
        else {
            
            VStack(alignment: .leading,
                   spacing: 20) {
                Text("OVERVIEW").font(.largeTitle).bold()
                Spacer()
                
                
                VStack(alignment: .leading) {
                    Text("TIME")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text("\(rideOver.duration_of_ride)").font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                }
                VStack(alignment: .leading) {
                    Text("AVG. SPEED")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    
                    Text("\(String(format: "%.1f mph", rideOver.average_speed))").font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading) {
                    Text("DIST.")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text("\(String(format: "%.2f miles", rideOver.location_of_rider))").font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                }
                
                MapView(region: rideOver.endingLocation, lineCoordinates: rideOver.locations)
                    .onTapGesture {
                        fullScreen = true
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color(UIColor.label), lineWidth: 3)
                    )
                
                VStack(alignment: .trailing) {
                    HStack {
                        Button {
                            navigationPath = NavigationPath()
                        } label: {
                            Text("FINISH").background(Color(UIColor.label))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor.label))
                                .foregroundColor(Color(UIColor.systemBackground))
                                .bold()
                        }
                        
                        Button {
                            navigationPath.append("CurrenRide")
                        } label: {
                            Text("RESUME").background(Color(UIColor.label))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor.label))
                                .foregroundColor(Color(UIColor.systemBackground))
                                .bold()
                        }
                        
                        
                    }
                }.frame(maxWidth: .infinity)
                Spacer()
            }.padding()
        }
        
    }
}

struct PostRidesView_Previews: PreviewProvider {
    static var previews: some View {
        let navigationPath = NavigationPath()
        PostRidesView(rideOver: BikeRide(duration_of_ride: "0", location_of_rider: 0.0, locations: [], endingLocation: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), average_speed: 0.0)
                      , navigationPath: .constant(navigationPath))
    }
}
