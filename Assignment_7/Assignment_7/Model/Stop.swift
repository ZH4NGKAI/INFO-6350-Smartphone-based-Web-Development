//
//  Stop.swift
//  Assignment_6
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import Foundation
class Stop {
    var name: String = ""
    var location: Location = Location(latitude: 0, longitude: 0)
    var address: String = ""
    
    init(){}
    init(name: String, location: Location, address: String) {
        self.name = name
        self.location = location
        self.address = address
    }
}

class Location {
    var latitude: Double = 0
    var longitude: Double = 0
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
