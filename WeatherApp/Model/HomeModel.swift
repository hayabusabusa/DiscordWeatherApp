//
//  HomeModel.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/08.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

protocol HomeModelDelegate: class {
    func onUpdated(currentWeather: CurrentWeather)
    func onError(error: Error)
}

final class HomeModel {
    
    private let client: APIClient
    
    weak var delegate: HomeModelDelegate?
    var currentWeather: CurrentWeather = CurrentWeather() {
        didSet{
            self.delegate?.onUpdated(currentWeather: currentWeather)
        }
    }
    
    init(client: APIClient = APIClient.shered) {
        self.client = client
    }
    
    func fetchCurrentWeather(cityName: String) {
        let path = "/weather"
        let cityNameQuery = URLQueryItem(name: "q", value: cityName)
        let unitsQuery = URLQueryItem(name: "units", value: "imperial")
        let apiKeyQuery = URLQueryItem(name: "APPID", value: Configuration.apiKey)
        
        client.get(path: path, queries: [cityNameQuery, unitsQuery, apiKeyQuery], type: CurrentWeather.self) { [weak self] (response, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.delegate?.onError(error: error)
                }
                if let response = response {
                    self.currentWeather = response
                }
            }
        }
    }
}
