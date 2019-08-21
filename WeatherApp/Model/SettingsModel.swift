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
    
}

struct SettingsModelImpl: SettingsModel {
    
    private let provider: LocationProvider = LocationProvider.shered
    
    
}
