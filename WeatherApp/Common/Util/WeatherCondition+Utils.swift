//
//  WeatherCondition+Utils.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
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
}
