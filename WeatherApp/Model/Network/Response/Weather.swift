//
//  Weather.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let main: String
    let desc: String
    
    private enum CodingKeys: String, CodingKey {
        case main
        case desc = "description"
    }
}
