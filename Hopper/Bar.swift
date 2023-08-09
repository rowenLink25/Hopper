//
//  Bar.swift
//  Hopper
//
//  Created by Rowen Link on 8/2/23.
//

import Foundation
import CoreLocation

struct Bar: Identifiable{
    var id : String = UUID().uuidString
    var numUsers : Int
    var name : String
    var image : String
    var longitude : String
    var latitude : String
    var emoji : String
    var coordinates : CLLocationCoordinate2D
}

