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
    @State private var preview = BarPreviewView(bar: Bar(numUsers: 0, name: "none", image:"", longitude: "0", latitude: "38.034833", emoji: "🫣", coordinates: CLLocationCoordinate2D(latitude: Double( "38.034833") ?? 0.0, longitude: Double("-78.500381") ?? 0.0)))
    @State private var region = MKCoordinateRegion.cVilleRegion().getBinding()
    
    
    var body: some View {
        ZStack{
            mapView
            VStack(alignment: .center, spacing : 0){
                header
                locationButton
                Spacer()
                preview
            }
            
        }
    }
    init(){
        self.viewModel.fetchData()
    }
}

struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MapScreenView()
    }
}
extension MapScreenView{
    private var mapView : some View{
        Map(coordinateRegion: region!, interactionModes: .all,  showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.bars){ bar in
            MapAnnotation(coordinate: bar.coordinates){
                BarAnnotationMapView()
                    .onTapGesture {
                        preview = BarPreviewView(bar: bar)
                        region = MKCoordinateRegion(center: bar.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)).getBinding()
                    }
            }
        }
        .ignoresSafeArea()
//        .onAppear(perform: self.viewModel.fetchData)
    }
    private var locationButton : some View {
        Button {
            var newRegion: Binding<MKCoordinateRegion>? {
                guard let location = locationManager.location else {
                    return MKCoordinateRegion.cVilleRegion().getBinding()
                }

                let newRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)

                return newRegion.getBinding()
            }
            region = newRegion
        } label: {
            Image(systemName: "location.circle")
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.systemBackground))
                .padding(4.5)
                .cornerRadius(12)
        }
        .border(.blue, width: 3)
        .background(.white)
        .cornerRadius(5)
        .frame(width: 40, height: 40)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(5)
    }
    private var header : some View {
        Label("What's Hoppin?", systemImage: "wineglass.fill")
            .scaledToFill()
            .cornerRadius(36)
            .font(.title).fontWeight(Font.Weight.bold)
            
            
    }
}

