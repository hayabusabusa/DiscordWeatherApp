//
//  HomeWeatherViewModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeWeatherViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let model: HomeWeatherModel
    
    // MARK: - Initializer
    
    init(model: HomeWeatherModel = HomeModelImpl()) {
        self.model = model
    }
}

extension HomeWeatherViewModel: ViewModelType {
    struct Input {
        let reloadTap: Signal<Void>
    }
    struct Output {
        let currentWeather: Driver<CurrentWeather>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: HomeWeatherViewModel.Input) -> HomeWeatherViewModel.Output {
        let currentWeatherRelay: BehaviorRelay<CurrentWeather> =
            .init(value: CurrentWeather(dt: 0, main: WeatherMain(temp: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0), weather: [], wind: Wind(speed: 0, deg: 0)))
        let isLoading: BehaviorRelay<Bool> = .init(value: true)
        
        model.fetchCurrent()
            .subscribe(onSuccess: { result in
                isLoading.accept(false)
                currentWeatherRelay.accept(result)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        input.reloadTap
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                isLoading.accept(true)
                self.model.fetchCurrent()
                    .subscribe(onSuccess: { result in
                        isLoading.accept(false)
                        currentWeatherRelay.accept(result)
                    }, onError: { error in
                        print(error)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        return Output(currentWeather: currentWeatherRelay.asDriver(),
                      isLoading: isLoading.asDriver())
    }
}
