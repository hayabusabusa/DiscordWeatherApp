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
    fileprivate static let kLocationLatitudeKey = "kLocationLatitudeKey"
    fileprivate static let kLocationLongitudeKey = "kLocationLongitudeKey"
    
    // MARK: - Current location
    
    static func saveCurrentLocation(_ cityName: String) {
        UserDefaults.standard.set(cityName, forKey: kCurrentLocationKey)
    }
    
    static func getCurrentLocation() -> String? {
        return UserDefaults.standard.string(forKey: kCurrentLocationKey)
    }
    
    static func removeCurrentLocation() {
        UserDefaults.standard.removeObject(forKey: kCurrentLocationKey)
    }
    
    // MARK: - Location
    
    static func saveLocation(latitude: Double, longitude: Double) {
        UserDefaults.standard.setValue(latitude, forKey: kLocationLatitudeKey)
        UserDefaults.standard.setValue(longitude, forKey: kLocationLongitudeKey)
    }
    
    static func getLocation() -> (latitude: Double, longitude: Double) {
        return (UserDefaults.standard.double(forKey: kLocationLatitudeKey),
                UserDefaults.standard.double(forKey: kLocationLongitudeKey))
    }
    
    static func removeLocation() {
        UserDefaults.standard.removeObject(forKey: kLocationLatitudeKey)
        UserDefaults.standard.removeObject(forKey: kLocationLongitudeKey)
    }
}
