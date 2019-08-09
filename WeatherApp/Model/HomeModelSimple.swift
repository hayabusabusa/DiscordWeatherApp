//
//  HomeModelSimple.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

class HomeModelSimple {
    
    weak var delegate: HomeModelDelegate?
    var currentWeather: CurrentWeather = CurrentWeather() {
        didSet{
            // 更新されるとdelegateを通じて通知
            self.delegate?.onUpdated(currentWeather: currentWeather)
        }
    }
    
    func fetchCurrentWeather(cityName: String) {
        var components = URLComponents(string: Configuration.baseUrl + "/weather")
        
        let cityNameQuery = URLQueryItem(name: "q", value: cityName)
        let unitsQuery = URLQueryItem(name: "units", value: "imperial")
        let apiKeyQuery = URLQueryItem(name: "APPID", value: Configuration.apiKey)
        components?.queryItems = [cityNameQuery, unitsQuery, apiKeyQuery]
        
        guard let url = components?.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                    let weather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    
                    // 取得した新しい天気に更新
                    DispatchQueue.main.async {
                        self?.currentWeather = weather
                    }
                } catch let error {
                    print(error)
                }
            } else {
                print("Responsed data is empty or something wrong.")
            }
        }
        
        task.resume()
    }
}
