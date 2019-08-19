//
//  HomeTemperatureCollectionViewController.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxCocoa

final class HomeTemperatureCollectionViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var viewModel: HomeTemperatureViewModel!
    private var dataSource: ForecastWeather = .init(list: []) {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Lifecycle
    
    static func instance(model: HomeTemperatureModel, reloadTap: Signal<Void>) -> HomeTemperatureCollectionViewController {
        let homeTemperatureCollectionViewController = HomeTemperatureCollectionViewController.newInstance()
        homeTemperatureCollectionViewController.viewModel = HomeTemperatureViewModel(model: model, reloadTap: reloadTap)
        return homeTemperatureCollectionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - UI

extension HomeTemperatureCollectionViewController {
    
    func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(HomeTemperatureCollectionViewCell.nib, forCellWithReuseIdentifier: HomeTemperatureCollectionViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        let input = type(of: viewModel).Input()
        let output = viewModel.transform(input: input)
        output.forecastWeather
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.dataSource = result
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
        collectionView.isHidden = isLoading
        indicatorView.isHidden = !isLoading
        if isLoading {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }
    }
}

// MARK: - CollctionView dataSource, delegate

extension HomeTemperatureCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTemperatureCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeTemperatureCollectionViewCell
        let item = dataSource.list[indexPath.row]
        cell.setupCell(dt: item.dt, temp: item.main.temp, weather: item.weather.first)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView layout

extension HomeTemperatureCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64.0, height: collectionView.bounds.size.height)
    }
}
