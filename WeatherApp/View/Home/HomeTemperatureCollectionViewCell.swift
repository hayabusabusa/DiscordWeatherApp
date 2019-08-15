//
//  HomeTemperatureCollectionViewCell.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class HomeTemperatureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Nib
    
    static let reuseIdentifier = "HomeTemperatureCollectionViewCell"
    static var nib: UINib {
        return UINib(nibName: "HomeTemperatureCollectionViewCell", bundle: nil)
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
