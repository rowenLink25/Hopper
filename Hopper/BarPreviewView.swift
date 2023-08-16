//
//  BarPreviewView.swift
//  Hopper
//
//  Created by Rowen Link on 8/9/23.
//

import SwiftUI
import CoreLocation

struct BarPreviewView: View {
    let bar : Bar
    var body: some View {
        if bar.name == "none"{
            
        }
        else{
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 16) {
                    imageSection
                    nameSection
                }
                VStack(alignment: .trailing, spacing: 20){
                    ratingSection
                    waitTimeSection
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y : 45)
            )
            .cornerRadius(10)
            .padding(15)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
        }
    }
}

struct BarPreviewView_Previews: PreviewProvider {

    static var previews: some View {
        BarPreviewView(bar: Bar(numUsers: 0, name: "Trinity Irish Pub", image:
                                    "https://images.squarespace-cdn.com/content/v1/5f19bb5120413145c7d53efc/2eca7220-053a-4a8d-8f8d-0d4379536cbe/Trinity.jpg", longitude: "-78.500381", latitude:
                                    "38.034833", emoji: "🫣", coordinates: CLLocationCoordinate2D(latitude: Double( "38.034833") ?? 0.0, longitude: Double("-78.500381") ?? 0.0)))
    }
}

extension BarPreviewView{
    private var imageSection: some View{
        ZStack{
            AsyncImage(url: URL(string: bar.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
            } placeholder: {
                ProgressView()
            }
        }
        .padding(6)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
    private var nameSection : some View {
        Text(bar.name)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var ratingSection : some View {
        Text("Rating: " + bar.emoji)
            .font(.title2)
            .fontWeight(.bold)

    }
    private var waitTimeSection : some View {
        Text("Estimated Wait Time (mins) : " + String(bar.numUsers))
            .font(.title2)
            .fontWeight(.bold)

    }
}

