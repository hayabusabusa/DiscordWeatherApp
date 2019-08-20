//
//  LocalSettings.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct LocalSettigs {
    
    fileprivate static let kCurrentLocationKey = "kCurrentLocationKey"
    
    // MARK: Current location
    
    static func saveCurrentLocation(_ cityName: String) {
        UserDefaults.standard.set(cityName, forKey: kCurrentLocationKey)
    }
    
    static func getCurrentLocation() -> String? {
        return UserDefaults.standard.string(forKey: kCurrentLocationKey)
    }
    
    static func removeCurrentLocation() {
        UserDefaults.standard.removeObject(forKey: kCurrentLocationKey)
    }
}
