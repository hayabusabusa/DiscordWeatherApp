//
//  HomeTemperatureViewModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeTemperatureViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let model: HomeTemperatureModel
    
    // MARK: - Initializer
    
    init(model: HomeTemperatureModel = HomeTemperatureModelImpl()) {
        self.model = model
    }
}

extension HomeTemperatureViewModel: ViewModelType {
    struct Input {
        // nil
    }
    struct Output {
        let forecastWeather: Driver<ForecastWeather>
    }
    
    func transform(input: HomeTemperatureViewModel.Input) -> HomeTemperatureViewModel.Output {
        let forecastWeatherRelay: BehaviorRelay<ForecastWeather> = .init(value: ForecastWeather(list: []))
        
        model.fetchForecast(params: ForecastParams(cityName: "Toyota,jp"))
            .subscribe(onSuccess: { result in
                forecastWeatherRelay.accept(result)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(forecastWeather: forecastWeatherRelay.asDriver())
    }
}
