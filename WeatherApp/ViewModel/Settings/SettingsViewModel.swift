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
        let onError: Driver<String>
    }
    
    func transform(input: SettingsViewModel.Input) -> SettingsViewModel.Output {
        let onError: PublishRelay<String> = .init()
        
        input.cellTap
            .subscribe(onNext: { [weak self] setting in
                guard let self = self else { return }
                switch setting {
                case .about:
                    self.wireframe.showUrl(url: Configuration.githubUrl)
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
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        return Output(onError: onError.asDriver(onErrorJustReturn: "Something wrong."))
    }
}
