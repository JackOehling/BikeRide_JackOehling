
import CoreLocation
import MapKit

struct BikeRide {
    // when implementing the CurrentBikeRide make both the duration and locaiton be variables that are set at the end
    // I am thinking that the location will have a distance method and the time will have it's own method to accumulate until the end
    // of the ride
    //
    var duration_of_ride: Int
    var location_of_rider: Double
    var locations: [CLLocationCoordinate2D]
    var endingLocation: MKCoordinateRegion

    init(duration_of_ride: Int, location_of_rider: Double, locations: [CLLocationCoordinate2D], endingLocation: MKCoordinateRegion) {
        self.duration_of_ride = duration_of_ride
        self.location_of_rider = location_of_rider
        self.locations = locations
        self.endingLocation = endingLocation
    }
    
    
    
}
