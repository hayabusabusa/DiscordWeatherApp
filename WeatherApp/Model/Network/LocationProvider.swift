//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/21.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

final class LocationProvider: NSObject {
    
    // MARK: - Properties
    
    static let shered: LocationProvider = .init()
    
    private let locationManager: CLLocationManager = .init()
    public let locationSubject: PublishSubject<Location> = .init()
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuth() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

// MARK: CLLocationManager delegate

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationSubject.onNext(Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.onError(error)
    }
}
