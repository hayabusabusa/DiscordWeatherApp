//
//  SettingsTableViewCell.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/19.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SettingsTableViewCell"
    static let rowHeight: CGFloat = 44
    static var nib: UINib {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UI
    
    func setupCell(title: String, content: String?) {
        titleLabel.text = title
        contentLabel.text = content
        contentLabel.isEnabled = content == nil
        selectionStyle = content == nil ? .default : .none
        accessoryType = content == nil ? .disclosureIndicator : .none
    }
    
}
