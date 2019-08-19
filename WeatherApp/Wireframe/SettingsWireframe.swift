//
//  SettingsWireframe.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import SafariServices

protocol SettingsWireframe {
    func showUrl(url: String)
}

struct SettingsWireframeImpl: SettingsWireframe {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showUrl(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        viewController?.present(safariVC, animated: true, completion: nil)
    }
}
