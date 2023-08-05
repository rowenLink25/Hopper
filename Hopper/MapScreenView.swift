//
//  MapScreenView.swift
//  Hopper
//
//  Created by Rowen Link on 8/1/23.
//

import SwiftUI
import MapKit


struct MapScreenView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        var region: Binding<MKCoordinateRegion>? {
            guard let location = locationManager.location else {
                return MKCoordinateRegion.cVilleRegion().getBinding()
            }
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            
            return region.getBinding()
        }
        if let region = region {
            Map(coordinateRegion: region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .ignoresSafeArea()
        }
        Text("Fuck off")
    }
}

struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MapScreenView()
    }
}
