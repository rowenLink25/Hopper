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
        locationManager.distanceFilter = 3.0
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
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
}
