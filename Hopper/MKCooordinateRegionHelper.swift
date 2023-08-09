//
//  MKCooordinateRegionHelper.swift
//  Hopper
//
//  Created by Rowen Link on 8/1/23.
//

import Foundation
import MapKit
import SwiftUI

extension MKCoordinateRegion {
    
    static func cVilleRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.03479716207155, longitude:  -78.50023596858671), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
