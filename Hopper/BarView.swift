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
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.gray)
                    .clipShape(Circle())
                    Text(bar.name)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(width: 100, alignment: .leading)
                        
                    Spacer()
                    Text("Rating: " + bar.emoji)
                    Spacer()
                    Text("Est. Wait (mins) : " + String(bar.waitTime)).font(.subheadline)
                }
            }
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Text("Bars")
                .font(.title)
                .fontWeight(.heavy))
            .onAppear() {
                self.viewModel.fetchData()
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView()
    }
}
