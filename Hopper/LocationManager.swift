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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 4.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = false
    }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            DispatchQueue.main.async {
                self.location = location
            }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
//test push
        case .notDetermined:
            print("DEBUG : status not determined")
        case .restricted:
            print("DEBUG : status restricted")
        case .denied:
            print("DEBUG : status denied")
        case .authorizedAlways:
            print("DEBUG : status authorized always")
        case .authorizedWhenInUse:
            print("DEBUG : status authorized when in use")
        @unknown default:
            break
        }
    }
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
