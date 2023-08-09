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
                        Text("Hopper")
                            .font(.title)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
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
