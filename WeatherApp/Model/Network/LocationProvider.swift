//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/21.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//
//  Medium
//  https://medium.com/location-tracking-tech/tracking-location-in-ios-vol-2-%E4%BD%8D%E7%BD%AE%E6%83%85%E5%A0%B1%E3%81%AE%E5%8F%96%E5%BE%97-c68c47548134
//

import Foundation
import RxSwift
import CoreLocation

final class LocationProvider: NSObject {
    
    // MARK: - Properties
    
    static let shered: LocationProvider = .init()
    
    private let locationManager: CLLocationManager = .init()
    public let locationAuthSubject: PublishSubject<Bool> = .init()
    public let locationSubject: PublishSubject<Location> = .init()
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuth() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationAuthSubject.onNext(false)
        case .authorizedWhenInUse:
            locationAuthSubject.onNext(true)
        case .denied:
            locationAuthSubject.onError(LocationError(localizedDescription: "System denied using location service when in use this application.\nPlease turn on location service."))
        default:
            locationAuthSubject.onError(LocationError(localizedDescription: "Unknown authorilzation status."))
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

// MARK: CLLocationManager delegate

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse:
            locationAuthSubject.onNext(true)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            locationSubject.onError(NSError(domain: "[Locations] is empty.", code: 999, userInfo: nil))
            return
        }
        locationSubject.onNext(Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.onError(error)
    }
}
