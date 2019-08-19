//
//  Settings.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/19.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct Settings {
    let desc: String
    let items: [Setting]
}

enum Setting: Int {
    case nowLocation
    case setLocation
    case updateLocation
    case version
    case about
}
