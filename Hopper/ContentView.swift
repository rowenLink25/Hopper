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
                        //you cand delete this its just funny
                        Image("test1")
                            .resizable()
                            .scaledToFit()
                        //
                        NavigationView {
                            List(viewModel.bars) { bar in
                                HStack(alignment: .center){
                                    AsyncImage(url: URL(string: bar.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 44, height: 44)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                    Text(bar.name).font(.title)
                                    Spacer()
                                    Text("Rating: " + bar.emoji)
                                    Spacer()
                                    Text("Est. Wait (mins) : " + String(bar.numUsers)).font(.subheadline)
                                }
                            }.navigationBarTitle("Bars")
                            .onAppear() {
                                self.viewModel.fetchData()
                            }
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                        }
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
