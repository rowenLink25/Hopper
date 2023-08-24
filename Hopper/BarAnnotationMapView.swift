//
//  BarAnnotationMapView.swift
//  Hopper
//
//  Created by Rowen Link on 8/8/23.
//

import SwiftUI

struct BarAnnotationMapView: View {
    var isSelected: Bool = false
    
    let accentColor = Color.red
    var body: some View {
        VStack(spacing: 0.0){
            Image(systemName: "wineglass.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
                .scaleEffect(isSelected ? 1.5 : 1)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 7, height: 7)
                .foregroundColor(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -2)
                .padding(.bottom, 40)
        }
        .animation(.easeInOut, value: isSelected)
    }
}

struct BarAnnotationMapView_Previews: PreviewProvider {
    static var previews: some View {
        BarAnnotationMapView()
    }
}
