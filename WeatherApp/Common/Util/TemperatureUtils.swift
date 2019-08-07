//
//  TemperatureUtils.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct TemperatureUtils {
    
    static func kelvinToCelsius(_ temperature: Double) -> Double {
        return (temperature - 273.0)
    }
    
    static func fahrenheitToCelsius(_ temperature: Double) -> Double {
        return (temperature - 32.0) / 1.8
    }
}
