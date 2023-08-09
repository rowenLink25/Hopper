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
    @ObservedObject private var viewModel = barViewModel()
    var body: some View {
        ZStack{
            var region: Binding<MKCoordinateRegion>? {
                guard let location = locationManager.location else {
                    return MKCoordinateRegion.cVilleRegion().getBinding()
                }
                
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                
                return region.getBinding()
            }

            if let region = region {
                Map(coordinateRegion: region, interactionModes: .all,  showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: viewModel.bars){ bar in
                    MapAnnotation(coordinate: bar.coordinates){
                        BarAnnotationMapView()
                    }
                }
                .ignoresSafeArea()
                
            }
            VStack(alignment: .center, spacing : 0){
                header
                Spacer()
                //code for on-click action to show location info
            }
            
        }

        Text("Fuck off")
    }
    init(){
        viewModel.fetchData()
    }
}

struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MapScreenView()
    }
}

private var header : some View {
    Label("What's Hoppin?", systemImage: "wineglass.fill")
        .scaledToFill()
        .cornerRadius(36)
        .font(.title).fontWeight(Font.Weight.bold)
        
        
}
