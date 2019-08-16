//
//  Timestamp+Util.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/16.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct TimestampUtil {
    
    private static var dateFormatter: DateFormatter = .init()
    
    static func hourString(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
