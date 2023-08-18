//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI

struct CurrentRunView: View {
    @State var isHomeViewable: Bool = true
    @State var isBeginRideViewable: Bool = true
    @State var isEndRideViewable: Bool = false
    
    
    @Binding var isActive: Bool
    @State var ride = Duration()
    
    var body: some View {
        VStack {
            if (isHomeViewable) {
                // have home disappear when the ride begins
                Button(action: {
                    isActive = false
                }) {
                    Text("Home")
                }
            }
            
            Text("Time: \(ride.initial)").onReceive(ride.timer){ _ in ride.beginTime()}
           
            if (isBeginRideViewable) {
                Button(action: {
                    ride.setIsRunning()
                    isEndRideViewable = true
                    isHomeViewable = false
                    isBeginRideViewable = false
                }) {
                    Text("Begin Ride")
                }
            }
            
            if (isEndRideViewable) {
                Button(action: {
                    ride.isRunning = false
                    isEndRideViewable = false
                    isHomeViewable = true
                    isBeginRideViewable = true
                    print("ended")
                }) {
                    Text("End Ride")
                }
            }
            
            
        }.buttonStyle(.bordered)
            .navigationBarHidden(true)
            
    }
}

struct CurrentRun_Previews: PreviewProvider {
    static var previews: some View {
        CurrentRunView(isActive: .constant(true))
    }
}
