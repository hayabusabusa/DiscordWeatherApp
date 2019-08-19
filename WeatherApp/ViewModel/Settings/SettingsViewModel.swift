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
    private let wireframe: SettingsWireframe
    
    // MARK: - Initializer
    
    init(wireframe: SettingsWireframe) {
        self.wireframe = wireframe
    }
}

extension SettingsViewModel: ViewModelType {
    struct Input {
       let cellTap: PublishRelay<Setting>
    }
    struct Output {
        
    }
    
    func transform(input: SettingsViewModel.Input) -> SettingsViewModel.Output {
        input.cellTap
            .subscribe(onNext: { [weak self] setting in
                guard let self = self else { return }
                switch setting {
                case .about:
                    self.wireframe.showUrl(url: Configuration.githubUrl)
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
