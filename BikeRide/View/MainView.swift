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
                }.padding(.top, 20)
                
                
                HStack {
                    NavigationLink(destination: CurrentRunView(isActive: $isActive)) {
                        Text("Begin Ride")
                            .padding(.horizontal, 35)
                            .padding(.vertical, 12)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(Font.custom("Helvetica-Bold", size: 26))
                            .cornerRadius(100)
                    }.padding(.top, 450)
                        .shadow(radius: 20)
                    
                }
                
            }.navigationTitle(Text("Ride"))
        }.onAppear {
            locationManager.reset()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
