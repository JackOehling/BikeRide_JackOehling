
import CoreLocation
import MapKit

struct BikeRide {
    // when implementing the CurrentBikeRide make both the duration and locaiton be variables that are set at the end
    // I am thinking that the location will have a distance method and the time will have it's own method to accumulate until the end
    // of the ride
    //
    var duration_of_ride: String
    var location_of_rider: Double
    var locations: [CLLocationCoordinate2D]
    var endingLocation: MKCoordinateRegion
    var average_speed: Double

    init(duration_of_ride: String, location_of_rider: Double, locations: [CLLocationCoordinate2D], endingLocation: MKCoordinateRegion, average_speed: Double) {
        self.duration_of_ride = duration_of_ride
        self.location_of_rider = location_of_rider
        self.locations = locations
        self.endingLocation = endingLocation
        self.average_speed = average_speed
    }
    
    init() {
        self.duration_of_ride = ""
        self.location_of_rider = 0.0
        self.locations = []
        endingLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        average_speed = 0.0
        
    }
    
    
    
}
