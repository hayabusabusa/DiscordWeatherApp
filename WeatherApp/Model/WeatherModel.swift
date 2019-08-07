//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Decodable {
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

struct Weather: Decodable {
    let main: String
    let desc: String
    
    private enum CodingKeys: String, CodingKey {
        case main
        case desc = "description"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
}
