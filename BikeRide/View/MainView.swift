//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    @ObservedObject var locationManager = LocationManager()
    @State var isActive: Bool = false
    
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                ZStack {
                    Map(coordinateRegion: $locationManager.region).disabled(true).opacity(0.5).ignoresSafeArea()
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.white.opacity(1)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                }
                
                
                HStack {
                    NavigationLink(destination: CurrentRunView(isActive: $isActive)) {
                        Text("Ride")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(400).aspectRatio(contentMode: .fill)
                    }
                    
                }
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
