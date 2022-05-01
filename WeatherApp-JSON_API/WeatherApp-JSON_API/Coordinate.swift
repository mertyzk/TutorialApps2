//
//  Coordinate.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation

struct Coordinate{
    let latitude : Double
    let longitude : Double
}

extension Coordinate : CustomStringConvertible {    // desc veriyor
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIsland : Coordinate {
        return Coordinate(latitude: 37.8267, longitude: -122.4233)
    }
    
    
}
