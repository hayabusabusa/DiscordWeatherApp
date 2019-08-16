//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

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
    
    private var viewModel: HomeViewModel!
    
    // MARK: - Lifecycle
    
    static func instance(viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController = HomeViewController.newInstance()
        homeViewController.viewModel = viewModel
        return homeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    // MARK: - IBAction
    
    @IBAction func tapReload(_ sender: UIButton) {
//        layoutHeader.alpha = 0
//        layoutContents.alpha = 0
//        layoutTemps.alpha = 0
    }
}

// MARK: - UI

extension HomeViewController {
    
    func setupUI() {
        // View
        layoutHeader.alpha = 0
        layoutContents.alpha = 0
        layoutTemps.alpha = 0
        
        // CollectionView
        let tempCollectionVC = HomeTemperatureCollectionViewController.instance(viewModel: HomeTemperatureViewModel())
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
        let input = type(of: viewModel).Input()
        let output = viewModel.transform(input: input)
        output.currentWeather
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.updateUI(weather: result)
            })
            .disposed(by: self.disposeBag)
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
        
        UIView.animate(withDuration: 1.4) { [weak self] in
            self?.layoutHeader.alpha = 1
            self?.layoutContents.alpha = 1
            self?.layoutTemps.alpha = 1
        }
    }
}
