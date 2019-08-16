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
    
    private let cityName: String = "Toyota,jp" // 天気を取得する都市の名前
    
    // MARK: - Lifecycle
    
    static func instance() -> HomeViewController {
        let homeViewController = HomeViewController.newInstance()
        return homeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCurrentWeather(by: cityName)
    }
    
    // MARK: - IBAction
    
    @IBAction func tapReload(_ sender: UIButton) {
        // 更新の時にもalphaの値を0にするのを忘れずに
        layoutHeader.alpha = 0
        layoutContents.alpha = 0
        layoutTemps.alpha = 0
        fetchCurrentWeather(by: cityName)
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
        
        // alphaの値を1に戻すようにアニメーションさせる
        // これで浮かび上がってくるようなアニメーションになる
        UIView.animate(withDuration: 1.4) { [weak self] in
            self?.layoutHeader.alpha = 1
            self?.layoutContents.alpha = 1
            self?.layoutTemps.alpha = 1
        }
    }
}

// MARK: - URLSession

extension HomeViewController {
    
    /// /weather にGETリクエストを行う
    ///
    /// - Parameter cityName: 取得したい都市の名前(APIのドキュメント参照)
    func fetchCurrentWeather(by cityName: String) {
        // リクエストするためのURLを作成
        // まずはベースURLにパス(/weather)を追加
        var components = URLComponents(string: Configuration.baseUrl + "/weather")
        
        // パラメーターを作成してURLにクエリとして追加(クエリに関してもAPIのドキュメント参照)
        // q ... 引数から受け取った天気を取得したい街, units... 単位のオプション ,APPID ... 発行してもらったAPIKey
        let cityNameQuery = URLQueryItem(name: "q", value: cityName)
        let unitsQuery = URLQueryItem(name: "units", value: "imperial")
        let apiKeyQuery = URLQueryItem(name: "APPID", value: Configuration.apiKey)
        components?.queryItems = [cityNameQuery, unitsQuery, apiKeyQuery]
        
        // 作成したURLがオプショナルなので、きちんとURLとして取得できるかアンラップ
        guard let url = components?.url else {
            return
        }
        
        // GETリクエストをするためのタスクを作成する
        // completionHandlerのdataにサーバーから返ってきたJsonが入っている
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            // [weak self]... 関数のキャプチャによりselfが循環参照になってしまうのを防止
            
            // 通信エラーがあった場合は終了
            if let error = error {
                print(error)
                return
            }
            
            // レスポンスがきちんとあるかをアンラップして確認
            if let data = data {
                do {
                    // 確認用
                    // 返ってきたJsonをdataからjsonの形式に直してコンソールに表示させる
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                    // 定義していたDecodable準拠のモデルオブジェクトにパースする
                    let weather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    
                    // 非同期の処理はメインスレッドでは行われないので、
                    // UIの更新処理は必ずメインスレッドで行うように指定する。
                    DispatchQueue.main.async {
                        self?.updateUI(weather: weather)
                    }
                } catch let error {
                    print(error)
                }
            } else {
                print("Responsed data is empty or something wrong.")
            }
        }
        
        // 作成したタスクをスタートさせる
        task.resume()
    }
}
