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
    func getLocation() -> Single<String>
    func updateLoaction() -> Observable<Location>
}

struct SettingsModelImpl: SettingsModel {
    
    private let provider: LocationProvider = LocationProvider.shered
    
    func getLocation() -> Single<String> {
        return Single.create { observer in
            if let current = LocalSettigs.getCurrentLocation() {
                observer(.success(current))
            } else {
                observer(.success(Configuration.defaultLocation))
            }
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
