//
//  WeatherCondition+Utils.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//
//  From OpenWeather Weather Conditions doc
//  https://openweathermap.org/weather-conditions
//

import UIKit

struct WeatherConditionUtils {
    
    static func conditionToIconImage(_ condition: String) -> UIImage? {
        switch condition {
        case "Thunderstorm":
            return UIImage(named: "ic_thunder")
        case "Drizzle":
            return UIImage(named: "ic_rainy")
        case "Rain":
            return UIImage(named: "ic_rainy")
        case "Snow":
            return UIImage(named: "ic_snow")
        case "Clear":
            return UIImage(named: "ic_sunny")
        case "Clouds":
            return UIImage(named: "ic_cloudy")
        default:
            return nil
        }
    }
    
    static func conditionToLandscapeImage(_ condition: String) -> UIImage? {
        switch condition {
        case "Thunderstorm":
            return UIImage(named: "ic_landscape_rainy")
        case "Drizzle":
            return UIImage(named: "ic_landscape_rainy")
        case "Rain":
            return UIImage(named: "ic_landscape_rainy")
        case "Snow":
            return UIImage(named: "ic_landscape_snow")
        case "Clear":
            return UIImage(named: "ic_landscape_sunny")
        case "Clouds":
            return UIImage(named: "ic_landscape_cloudy")
        default:
            return nil
        }
    }
    
    static func weatherToIconImage(_ weather: Weather) -> UIImage? {
        switch weather.main {
        case "Thunderstorm":
            return UIImage(named: "ic_thunder")
        case "Drizzle":
            return UIImage(named: "ic_rainy")
        case "Rain":
            return UIImage(named: "ic_rainy")
        case "Snow":
            return UIImage(named: "ic_snow")
        case "Clear":
            return UIImage(named: "ic_sunny")
        case "Clouds":
            if weather.desc == "few clouds" {
                return UIImage(named: "ic_sunny")
            }
            return UIImage(named: "ic_cloudy")
        default:
            return nil
        }
    }
    
    static func weatherToLandscapeImage(_ weather: Weather) -> UIImage? {
        switch weather.main {
        case "Thunderstorm":
            return UIImage(named: "ic_landscape_rainy")
        case "Drizzle":
            return UIImage(named: "ic_landscape_rainy")
        case "Rain":
            return UIImage(named: "ic_landscape_rainy")
        case "Snow":
            return UIImage(named: "ic_landscape_snow")
        case "Clear":
            return UIImage(named: "ic_landscape_sunny")
        case "Clouds":
            if weather.desc == "few clouds" {
                return UIImage(named: "ic_landscape_sunny")
            }
            return UIImage(named: "ic_landscape_cloudy")
        default:
            return nil
        }
    }
}
