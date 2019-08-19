//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = BaseNavigationController(rootViewController: HomeViewController.instance(model: HomeWeatherModelImpl()))
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

