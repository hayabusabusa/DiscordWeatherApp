//
//  HomeTemperatureCollectionViewController.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class HomeTemperatureCollectionViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

// MARK: - CollctionView dataSource, delegate

extension HomeTemperatureCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTemperatureCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeTemperatureCollectionViewCell
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
