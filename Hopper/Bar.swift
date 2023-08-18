//
//  Bar.swift
//  Hopper
//
//  Created by Rowen Link on 8/2/23.
//

import Foundation
import CoreLocation

struct Bar: Identifiable, Equatable{
    static func == (lhs: Bar, rhs: Bar) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id : String
    var numUsers : Int
    var name : String
    var image : String
    var longitude : String
    var latitude : String
    var emoji : String
    var coordinates : CLLocationCoordinate2D
}

