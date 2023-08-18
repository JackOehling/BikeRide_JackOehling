//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView().tabItem {
                Image(systemName: "figure.outdoor.cycle")
                Text("Main")
            }
            PastRidesView().tabItem{
                Image(systemName: "calendar")
                Text("Past Rides")
            }
            MeView().tabItem{
                Image(systemName: "person")
                Text("Me")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
