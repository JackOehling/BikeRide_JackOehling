//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            TabView {
                HomeView().tabItem {
                    Image(systemName: "figure.outdoor.cycle")
                    Text("Ride")
                }.onAppear {
                   name = "RIDE"
                }
                PastRidesView().tabItem{
                    Image(systemName: "calendar")
                    Text("Past Rides")
                }.onAppear {
                    name = "PAST RIDES"
                 }
                MeView().tabItem{
                    Image(systemName: "person")
                    Text("Me")
                }.onAppear {
                    name = "ME"
                 }
            }
            .accentColor(Color(UIColor.label))
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }.navigationTitle(Text(name))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
