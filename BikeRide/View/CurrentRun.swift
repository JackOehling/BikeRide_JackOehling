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
    @State var ride_duration = Duration()
    @ObservedObject var ride_distance = LocationManager()
    @State var isMoving: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                    
                Text("Time: \(ride_duration.initial)").onReceive(ride_duration.timer){ _ in ride_duration.beginTime()}
                
                Text("Distance: \(ride_distance.totalDistance)")
                
                if (isEndRideViewable) {
                    Button(action: {
                        ride_distance.toggleTracking()
                        ride_duration.isRunning = false
                        isEndRideViewable = false
                        isHomeViewable = true
                        isBeginRideViewable = true
                        print("ended")
                    }) {
                        Text("End Ride")
                    }
                }
                    
                
                
                HStack {
                    if (isBeginRideViewable) {
                        Button(action: {
                            ride_distance.toggleTracking()
                            ride_duration.setIsRunning()
                            isEndRideViewable = true
                            isHomeViewable = false
                            isBeginRideViewable = false
                        }) {
                            Text("Begin Ride")
                        }
                    }
                    
                }
            }.buttonStyle(.bordered)
        }
        }
}

struct CurrentRun_Previews: PreviewProvider {
    static var previews: some View {
        CurrentRunView(isActive: .constant(true))
    }
}
