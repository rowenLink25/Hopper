//
//  Bar.swift
//  Hopper
//
//  Created by Rowen Link on 8/2/23.
//

import Foundation

struct Bar: Identifiable{
    var id : String = UUID().uuidString
    var numUsers : Int
    var name : String
    var image : String
    var longitude : Int
    var latitude : Int
    var emoji : String
}

