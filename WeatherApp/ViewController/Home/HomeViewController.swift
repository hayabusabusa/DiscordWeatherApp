//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var layoutHeader: UIView!
    @IBOutlet weak var layoutContents: UIView!
    @IBOutlet weak var landscapeImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // MARK: - Properties
    
    private let model: HomeModel = HomeModel()
    private let cityName: String = "Toyota,jp" // 天気を取得する都市の名前
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        model.delegate = self
        model.fetchCurrentWeather(cityName: cityName)
    }
    
    // MARK: - IBAction
    
    @IBAction func tapReload(_ sender: UIButton) {
        // 更新の時にもalphaの値を0にするのを忘れずに
        layoutHeader.alpha = 0
        layoutContents.alpha = 0
        model.fetchCurrentWeather(cityName: cityName)
    }
}

// MARK: - UI

extension HomeViewController {
    
    func setupUI() {
        // ふわっと表示させたいのでalpha(透明度)の値をアニメーションさせる
        // 一旦0に設定して非同期の処理が完了後に1にするアニメーションを行う
        layoutHeader.alpha = 0
        layoutContents.alpha = 0
    }
    
    func updateUI(weather: CurrentWeather) {
        temperatureLabel.text = String(format: "%.1f°", TemperatureUtils.fahrenheitToCelsius(weather.main.temp))
        weatherLabel.text = weather.weather.first?.desc ?? "unknown"
        minLabel.text = String(format: "%.1f°", TemperatureUtils.fahrenheitToCelsius(weather.main.tempMin))
        maxLabel.text = String(format: "%.1f°", TemperatureUtils.fahrenheitToCelsius(weather.main.tempMax))
        windLabel.text = String(format: "%.1fmph", weather.wind.speed)
        humidityLabel.text = "\(weather.main.humidity)%"
        
        if let condition = weather.weather.first?.main {
            landscapeImageView.image = WeatherConditionUtils.conditionToLandscapeImage(condition)
            iconImageView.image = WeatherConditionUtils.conditionToIconImage(condition)
        }
        
        // alphaの値を1に戻すようにアニメーションさせる
        // これで浮かび上がってくるようなアニメーションになる
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.layoutHeader.alpha = 1
            self?.layoutContents.alpha = 1
        }
    }
}

// MARK: - Model delegate

extension HomeViewController: HomeModelDelegate {
    
    func onSuccess(currentWeather: CurrentWeather) {
        updateUI(weather: currentWeather)
    }
    
    func onError(error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
