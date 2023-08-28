//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var locationManager = LocationManager()
    @State var isActive: Bool = false
    @State private var navigationPath: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                ZStack {
                    Map(coordinateRegion: $locationManager.region).disabled(true).opacity(0.5).ignoresSafeArea()
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color(UIColor.systemBackground).opacity(1.2)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                }
                
                
                HStack {
                    
                    Button {
                        navigationPath.append("CurrentRide")
                    } label: {
                        Text("BEGIN RIDE")
                            .padding(.horizontal, 35)
                            .padding(.vertical, 12)
                            .background(Color(UIColor.label))
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 25, weight: .semibold))
                    }.padding(.top, 450)
                        .shadow(radius: 20)
                    
                    
                }
                
            }
        }.navigationDestination(for: String.self) { name in
            switch name{
            case "CurrentRide":
                CurrentRideView(navigationPath: $navigationPath)
            default:
                EmptyView()
            }
        }
        
        .onAppear {
            locationManager.reset()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
