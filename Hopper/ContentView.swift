//
//  ContentView.swift
//  Hopper
//
//  Created by Rowen Link on 7/31/23.
//

import SwiftUI
import MapKit
import CoreLocation


struct ContentView: View {
    @ObservedObject private var viewModel = barViewModel()
    var body: some View {
            NavigationStack{
                ZStack{
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea()
                        
                    VStack{
                        Image("title")
                            .scaledToFill()
                        BarView()
                        Spacer()
                        NavigationLink("Go to map")
                        {
                            MapScreenView()
                                
                        }
                    }
                }
            }
            .navigationTitle("Bars")
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
