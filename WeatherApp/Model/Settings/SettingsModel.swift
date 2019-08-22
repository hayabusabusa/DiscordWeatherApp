//
//  SettingsModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/21.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingsModel {
    func getCurrentLocation() -> Single<String>
    func getSpecialLocation() -> Single<String>
    func saveCurrentLocation(_ cityName: String) -> Completable
    func updateLoaction() -> Observable<Location>
}

struct SettingsModelImpl: SettingsModel {
    
    private let provider: LocationProvider = LocationProvider.shered
    
    func getCurrentLocation() -> Single<String> {
        return Single.create { observer in
            if let current = LocalSettigs.getCurrentLocation() {
                observer(.success(current))
            } else {
                observer(.success(Configuration.defaultLocation))
            }
            return Disposables.create()
        }
    }
    
    func getSpecialLocation() -> Single<String> {
        return Single.create { observer in
            let specialLocation = SpecialLocationUtils.getSpecialLocation()
            LocalSettigs.saveCurrentLocation(specialLocation)
            observer(.success(specialLocation))
            return Disposables.create()
        }
    }
    
    func saveCurrentLocation(_ cityName: String) -> Completable {
        return Completable.create { observer in
            LocalSettigs.saveCurrentLocation(cityName)
            observer(.completed)
            return Disposables.create()
        }
    }
    
    func updateLoaction() -> Observable<Location> {
        provider.requestAuth()
        return provider.locationAuthSubject.asObserver()
            .filter { return $0 == true }
            .flatMap { _ -> Observable<Location> in
                self.provider.requestLocation()
                return self.provider.locationSubject.asObserver()
            }
    }
}
