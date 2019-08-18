//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxCocoa

final class HomeViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var layoutHeader: UIView!
    @IBOutlet weak var layoutContents: UIView!
    @IBOutlet weak var layoutTemps: UIView!
    @IBOutlet weak var landscapeImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - Properties
    
    private var viewModel: HomeWeatherViewModel!
    
    // MARK: - Lifecycle
    
    static func instance(viewModel: HomeWeatherViewModel) -> HomeViewController {
        let homeViewController = HomeViewController.newInstance()
        homeViewController.viewModel = viewModel
        return homeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - UI

extension HomeViewController {
    
    func setupUI() {
        // CollectionView
        let tempCollectionVC = HomeTemperatureCollectionViewController
            .instance(viewModel: HomeTemperatureViewModel(reloadTap: reloadButton.rx.tap.asSignal()))
        layoutTemps.addSubview(tempCollectionVC.view)
        addChild(tempCollectionVC)
        tempCollectionVC.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            tempCollectionVC.view.topAnchor.constraint(equalTo: layoutTemps.topAnchor, constant: 0),
            tempCollectionVC.view.leadingAnchor.constraint(equalTo: layoutTemps.leadingAnchor, constant: 0),
            tempCollectionVC.view.trailingAnchor.constraint(equalTo: layoutTemps.trailingAnchor, constant: 0),
            tempCollectionVC.view.bottomAnchor.constraint(equalTo: layoutTemps.bottomAnchor, constant: 0)
            ])
    }
    
    func bindViewModel() {
        let input = type(of: viewModel).Input(reloadTap: reloadButton.rx.tap.asSignal())
        let output = viewModel.transform(input: input)
        output.currentWeather
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.updateUI(weather: result)
            })
            .disposed(by: self.disposeBag)
        output.isLoading
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.showLoading(result)
            })
            .disposed(by: self.disposeBag)
    }
    
    func showLoading(_ isLoading: Bool) {
        UIView.animate(withDuration: 1.0) { [weak self] in
                        self?.layoutHeader.alpha = isLoading ? 0 : 1
                        self?.layoutTemps.alpha = isLoading ? 0 : 1
        }
    }
    
    func updateUI(weather: CurrentWeather) {
        temperatureLabel.text = String(format: "%.1f", TemperatureUtils.fahrenheitToCelsius(weather.main.temp))
        weatherLabel.text = weather.weather.first?.desc ?? "unknown"
        minLabel.text = String(format: "%.1f", TemperatureUtils.fahrenheitToCelsius(weather.main.tempMin))
        maxLabel.text = String(format: "%.1f", TemperatureUtils.fahrenheitToCelsius(weather.main.tempMax))
        windLabel.text = String(format: "%.1f", weather.wind.speed)
        humidityLabel.text = "\(weather.main.humidity)"
        
        if let condition = weather.weather.first?.main {
            landscapeImageView.image = WeatherConditionUtils.conditionToLandscapeImage(condition)
            iconImageView.image = WeatherConditionUtils.conditionToIconImage(condition)
        }
    }
}
