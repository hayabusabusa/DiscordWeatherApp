//
//  HomeModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol HomeModel {
    func fetchCurrent(params: CurrentParams) -> Single<CurrentWeather>
}

struct HomeModelImpl: HomeModel {
    
    private let provider: MoyaProvider<WeatherAppAPI> = WeatherAppAPIProvider.shered
    
    func fetchCurrent(params: CurrentParams) -> Single<CurrentWeather> {
        return provider.rx.request(.current(with: params))
            .filterSuccessfulStatusCodes()
            .map(CurrentWeather.self)
    }
}
