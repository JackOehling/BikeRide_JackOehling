
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var totalDistance: Double = 0
    private var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        if let last = lastLocation {
            let distance = newLocation.distance(from: last)
            let distance_in_miles = distance / 1609
            totalDistance += distance_in_miles
        }
        
        lastLocation = newLocation
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        // Handle the location error here
//        let errorDescription = (error as NSError).localizedDescription
//        print("Location error: \(errorDescription)")
//    }
    
//    func toggleTracking() {
//        isMoving.toggle()
//        print("in toggle tracking")
//        if (isMoving) {
//            print("in toggle tracking total distance")
//            totalDistance = 0.0
//            print("\(totalDistance)")
//        } else {
//            locationManager.stopUpdatingLocation()
//        }
//    }
    
    
}
