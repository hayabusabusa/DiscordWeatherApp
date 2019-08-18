//
//  HomeWeatherModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol HomeWeatherModel {
    func fetchCurrent() -> Single<CurrentWeather>
}

struct HomeModelImpl: HomeWeatherModel {
    
    private let provider: MoyaProvider<WeatherAppAPI> = WeatherAppAPIProvider.shered
    
    func fetchCurrent() -> Single<CurrentWeather> {
        return provider.rx.request(.current(with: CurrentParams(cityName: "Toyota,jp")))
            .filterSuccessfulStatusCodes()
            .map(CurrentWeather.self)
    }
}
