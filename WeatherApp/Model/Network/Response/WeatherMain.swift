//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct WeatherMain: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}
