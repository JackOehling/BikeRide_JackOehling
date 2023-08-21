


import CoreLocation



class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var totalDistance: Double = 0
    var isMoving: Bool = false
    private var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // sets the new location to the most updated location from locations
        guard let newLocation = locations.last else {return}
        
        if let last_in_locations = lastLocation {
            // tracking the distance from the last location
            let distance = newLocation.distance(from: last_in_locations)
            totalDistance += distance
        }
        
        lastLocation = newLocation
    }
    
    func toggleTracking() {
        isMoving.toggle()
        if (isMoving) {
            totalDistance = 0.0
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}
