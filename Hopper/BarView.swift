//
//  BarView.swift
//  Hopper
//
//  Created by Rowen Link on 8/8/23.
//

import SwiftUI

struct BarView: View {
    @ObservedObject private var viewModel = barViewModel()
    var body: some View {
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
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView()
    }
}
