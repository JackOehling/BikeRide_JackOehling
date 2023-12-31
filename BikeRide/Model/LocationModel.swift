
import SwiftUI
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var all_speeds: [Double] = []
    @Published var avg_speed: Double = 0
    @Published var distance_in_miles: Double = 0
    @Published var allLocations: [CLLocation] = []
    @Published var totalDistance: Double = 0
    @Published var startedRiding: Bool = false
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var lastLocation: CLLocation?
    @Published var isRideInProgress = false
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        allLocations.append(contentsOf: locations)
        
        
        if let speed = locations.last?.speed {
            all_speeds.append(speed)
        }
        
        guard let newLocation = locations.last else { return }
        
        if isRideInProgress {
                if let last = lastLocation {
                    let distance = newLocation.distance(from: last)
                    let distance_in_miles = distance / 1609
                    latitude += 0.002
                    longitude += 0.002
                    totalDistance += distance_in_miles
                }
                
                lastLocation = newLocation
            }
        }
        
        
        
        
        // fix this later
        // potentially will have to create two trackers
//        DispatchQueue.main.async {
//            self.region = MKCoordinateRegion(center: newLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func convertCllocation(locationList: [CLLocation]) -> [CLLocationCoordinate2D] {
        print("\(allLocations)")
        var output = [CLLocationCoordinate2D]()
        locationList.forEach{ location in
            output.append(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        }
        
        return output
    }
    
    func average_speed() -> Double {
        var speeds = 0.0
        all_speeds.forEach{ speed in
            speeds += (speed * 2.237)
        }
        var output = speeds / Double(all_speeds.count)
        
        if output.isNaN {output = 0}
        avg_speed = output
        print("\(all_speeds)")
        return output 
    }
    
    
    
    func reset() {
        allLocations = []
        totalDistance = 0
        distance_in_miles = 0
        isRideInProgress = false
        all_speeds = []
    }
    
    
    
    
    
}
