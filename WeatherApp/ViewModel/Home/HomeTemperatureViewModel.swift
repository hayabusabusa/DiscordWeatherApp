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
    
    private let reloadTap: Signal<Void>
    
    // MARK: - Initializer
    
    init(model: HomeTemperatureModel = HomeTemperatureModelImpl(),
         reloadTap: Signal<Void>) {
        self.model = model
        self.reloadTap = reloadTap
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
        
        model.fetchForecast()
            .subscribe(onSuccess: { result in
                forecastWeatherRelay.accept(result)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        self.reloadTap
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.model.fetchForecast()
                    .subscribe(onSuccess: { result in
                        forecastWeatherRelay.accept(result)
                    }, onError: { error in
                        print(error)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        return Output(forecastWeather: forecastWeatherRelay.asDriver())
    }
}
