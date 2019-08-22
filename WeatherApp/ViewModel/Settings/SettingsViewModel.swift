//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingsViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let model: SettingsModel
    private let wireframe: SettingsWireframe
    
    // MARK: - Initializer
    
    init(model: SettingsModel = SettingsModelImpl(), wireframe: SettingsWireframe) {
        self.model = model
        self.wireframe = wireframe
    }
}

extension SettingsViewModel: ViewModelType {
    struct Input {
        let cellTap: PublishRelay<Setting>
    }
    struct Output {
        let currentLocation: Driver<String>
        let onError: Driver<String>
    }
    
    func transform(input: SettingsViewModel.Input) -> SettingsViewModel.Output {
        let currentLocation: BehaviorRelay<String> = .init(value: Configuration.defaultLocation)
        let onError: PublishRelay<String> = .init()
        
        model.getCurrentLocation()
            .subscribe(onSuccess: { cityName in
                currentLocation.accept(cityName)
            })
            .disposed(by: disposeBag)
        
        input.cellTap
            .subscribe(onNext: { [weak self] setting in
                guard let self = self else { return }
                switch setting {
                case .setLocation:
                    self.model.getSpecialLocation()
                        .subscribe(onSuccess: { cityName in
                            currentLocation.accept(cityName)
                        })
                        .disposed(by: self.disposeBag)
                case .updateLocation:
                    self.model.updateLoaction()
                        .subscribe(onNext: { location in
                            print(location)
                        }, onError: { error in
                            if let err = error as? LocationError {
                                onError.accept(err.localizedDescription)
                            } else {
                                onError.accept(error.localizedDescription)
                            }
                        })
                        .disposed(by: self.disposeBag)
                case .about:
                    self.wireframe.showUrl(url: Configuration.githubUrl)
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        return Output(currentLocation: currentLocation.asDriver(),
                      onError: onError.asDriver(onErrorJustReturn: "Something wrong."))
    }
}
