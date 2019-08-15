//
//  WeatherAppAPI.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Moya

enum WeatherAppAPI {
    case current(with: CurrentParams)
    case forecast(with: ForecastParams)
}

extension WeatherAppAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Configuration.baseUrl) else {
            fatalError("Base URL is not correct")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .current:
            return "/weather"
        case .forecast:
            return "/forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .current(let params):
            parameters["q"] = params.cityName
        case .forecast(let params):
            parameters["q"] = params.cityName
        }
        
        parameters["units"] = "imperial"
        parameters["APPID"] = Configuration.apiKey
        return parameters
    }
    
    var parameterEncoding: Moya.URLEncoding {
        switch self {
        default:
            return .queryString
        }
    }
    
    var task: Moya.Task {
        switch self {
        default:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
