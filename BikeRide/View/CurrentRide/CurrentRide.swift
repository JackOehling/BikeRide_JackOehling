//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import MapKit

struct CurrentRideView: View {
    @ObservedObject var currentRideViewModel: CurrentRideViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading) {
                        Text("TIME")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        Text("\(currentRideViewModel.duration.formattedDuration(from: TimeInterval(currentRideViewModel.duration.initial)))").onReceive(currentRideViewModel.duration.timer){ _ in currentRideViewModel.duration.beginTime()}
                            .font(.system(size: 35, weight: .bold))
                            .bold()
                            .foregroundColor(Color(UIColor.label))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("AVG. SPEED")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Text("\(String(format: "%.2f", currentRideViewModel.getAverageSpeed())) mph")
                            .font(.system(size: 35, weight: .bold))
                            .bold()
                            .foregroundColor(Color(UIColor.label))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("DISTANCE")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Text(String(format: "%.2f miles", currentRideViewModel.locationManager.totalDistance))
                            .font(.system(size: 55, weight: .bold))
                            .bold()
                            .foregroundColor(Color(UIColor.label))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    currentRideViewModel.startAndEndRide()
                })  {
                    Text(currentRideViewModel.isMoving ? "PAUSE" : "START")
                        .font(.largeTitle)
                        .bold()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .background(Color(UIColor.label))
                }
            }
        .padding(40)
        .onDisappear {
            currentRideViewModel.locationManager.isRideInProgress = false
            currentRideViewModel.locationManager.totalDistance = 0
            currentRideViewModel.locationManager.lastLocation = nil
            currentRideViewModel.resetAvgSpeed()
            currentRideViewModel.duration.resetTime()
            currentRideViewModel.reset = true
            
        }
    }
}

struct CurrentRideView_Previews: PreviewProvider {
    static var previews: some View {
        let navigationPath = NavigationPath()
        return CurrentRideView(currentRideViewModel: CurrentRideViewModel(), navigationPath: .constant(navigationPath))
    }
}
