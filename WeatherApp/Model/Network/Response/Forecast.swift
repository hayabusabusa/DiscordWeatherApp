//
//  Forecast.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/16.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let dt: Double
    let main: WeatherMain
    let weather: [Weather]
    let wind: Wind
}
