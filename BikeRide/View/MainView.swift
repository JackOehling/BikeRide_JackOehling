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
                }.padding(.top, 150)
                
                
                HStack {
                    NavigationLink(destination: CurrentRunView(isActive: $isActive)) {
                        Text("Begin")
                            .padding(35)
                            .background(Color(red: 24.3/255.0, green: 70.6/255.0, blue: 53.7/255.0))
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(Font.custom("Helvetica-Bold", size: 28))
                            .clipShape(Circle())
                    }.padding(.top, 475)
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
