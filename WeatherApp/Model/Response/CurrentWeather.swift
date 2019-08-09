//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    init(dt: Double = 0.0, main: Main = Main(), weather: [Weather] = [], wind: Wind = Wind()) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.wind = wind
    }
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
    
    init(temp: Double = 0.0, tempMin: Double = 0.0, tempMax: Double = 0.0, pressure: Double = 0.0, humidity: Double = 0.0) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
}

struct Weather: Decodable {
    let main: String
    let desc: String
    
    private enum CodingKeys: String, CodingKey {
        case main
        case desc = "description"
    }
    
    init(main: String = "", desc: String = "") {
        self.main = main
        self.desc = desc
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
    
    init(speed: Double = 0.0, deg: Double = 0.0) {
        self.speed = speed
        self.deg = deg
    }
}
