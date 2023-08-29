//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI

struct Duration {
    var isRunning: Bool = false
    var initial = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    mutating func beginTime() -> Void {
        if(initial >= 0 && isRunning) {
            initial += 1
        } else {
            isRunning = false
        }
    }
    
    mutating func setIsRunning() -> Void {
        isRunning = true
    }
    
    func formattedDuration(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
    
    mutating func resetTime() -> Void {
        initial = 0
    }
    
    
    
}



