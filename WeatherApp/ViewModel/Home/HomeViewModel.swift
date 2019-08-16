//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let model: HomeModel
    
    // MARK: - Initializer
    
    init(model: HomeModel = HomeModelImpl()) {
        self.model = model
    }
}

extension HomeViewModel: ViewModelType {
    struct Input {
        // nil
    }
    struct Output {
        let currentWeather: Driver<CurrentWeather>
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        let currentWeatherRelay: BehaviorRelay<CurrentWeather> =
            .init(value: CurrentWeather(dt: 0, main: WeatherMain(temp: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0), weather: [], wind: Wind(speed: 0, deg: 0)))
        
        model.fetchCurrent(params: CurrentParams(cityName: "Toyota,jp"))
            .subscribe(onSuccess: { result in
                currentWeatherRelay.accept(result)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(currentWeather: currentWeatherRelay.asDriver())
    }
}
