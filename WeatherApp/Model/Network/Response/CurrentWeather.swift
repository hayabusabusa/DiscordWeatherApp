//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let dt: Double
    let main: WeatherMain
    let weather: [Weather]
    let wind: Wind
}
