//
//  SpecialLocation+Utils.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/22.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct SpecialLocationUtils {
    
    static private let locations: [String] = [
        "Toyota,jp",
        "London,uk",
        "Nagoya-shi,jp",
        "New York,us"
    ]
    
    static func getSpecialLocation() -> String {
        return locations[Int.random(in: 0..<locations.count)]
    }
}
