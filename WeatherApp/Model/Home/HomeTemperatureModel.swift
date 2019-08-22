//
//  HomeTemperatureModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol HomeTemperatureModel {
    func fetchForecast() -> Single<ForecastWeather>
}

struct HomeTemperatureModelImpl: HomeTemperatureModel {
    
    private let provider: MoyaProvider<WeatherAppAPI> = WeatherAppAPIProvider.shered
    
    func fetchForecast() -> Single<ForecastWeather> {
        return provider.rx.request(.forecast(with: ForecastParams(cityName: LocalSettigs.getCurrentLocation() ?? Configuration.defaultLocation)))
            .filterSuccessfulStatusCodes()
            .map(ForecastWeather.self)
    }
}
