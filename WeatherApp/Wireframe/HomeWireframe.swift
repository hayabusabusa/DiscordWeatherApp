//
//  HomeWireframe.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/19.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol HomeWireframe {
    func showSettings()
}

struct HomeWireframeImpl: HomeWireframe {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showSettings() {
        let settingsVC = SettingsViewController.instance()
        viewController?.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
