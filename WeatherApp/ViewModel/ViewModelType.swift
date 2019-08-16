//
//  ViewModelType.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/16.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
