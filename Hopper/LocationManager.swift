//
//  LocationDataManager.swift
//  Hopper
//
//  Created by Rowen Link on 7/31/23.
//

import Foundation
import CoreLocation
final class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 4.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = false
        locationManager.delegate = self
    }
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//            switch manager.authorizationStatus {
//            case .authorizedWhenInUse:  // Location services are available.
//                authorizationStatus = .authorizedWhenInUse
//                locationManager.requestAlwaysAuthorization()
//                break
//
//            case .restricted:  // Location services currently unavailable.
//                // Insert code here of what should happen when Location services are NOT authorized
//                authorizationStatus = .restricted
//
//                break
//
//            case .denied:  // Location services currently unavailable.
//                // Insert code here of what should happen when Location services are NOT authorized
//                authorizationStatus = .denied
//
//                break
//
//            case .notDetermined:        // Authorization not determined yet.
//                authorizationStatus = .notDetermined
//                manager.requestWhenInUseAuthorization()
//                break
//
//            default:
//                break
//            }
//        }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            DispatchQueue.main.async {
                self.location = location
            }
        
    }
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("entered location")
//    }
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        print("exited location")
//    }

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    let newLocation = locations.last!
//    // We've been passed a cached result so ignore and continue.
//    if newLocation.timestamp.timeIntervalSinceNow < -5 {
//        return
//    }
//    // horizontalAccuracy < 0 indicates invalid result so ignore and continue.
//    if newLocation.horizontalAccuracy < 0 {
//        return
//    }
//    // Calculate the distance between the new and previous locations.
//    var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
//    if let location = location { // location is my previously stored value.
//        distance = newLocation.distance(from: location)
//    }
//    // If newLocation is more accurate than the previous (if previous exists) then use it.
//    if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
////            lastLocationError = nil
//        location = newLocation
//
//        // When newLocation's accuracy is better than our desired accuracy then stop.
//        if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
//            location = location
//        }
//    } else if distance < 5 {
//        let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
//        if timeInterval > 10 {
//            location = location
//        }
//    }
//
//    print(newLocation)
//    }
}
