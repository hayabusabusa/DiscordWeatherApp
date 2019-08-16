//
//  WeatherAppAPIProvider.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Moya

final class WeatherAppAPIProvider {
    
    static let shered: MoyaProvider<WeatherAppAPI> = WeatherAppAPIProvider.create()
    
    private init () {}
    
    static private func create() -> MoyaProvider<WeatherAppAPI> {
        return MoyaProvider<WeatherAppAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
}
