//
//  Storyboardable.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/15.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol Storyboardable {
    
}

extension Storyboardable where Self: UIViewController {
    
    static func instantiateWithStoryboard() -> Self {
        let nameType = String(describing: type(of: self))
        let storyboardName = String(describing: nameType).components(separatedBy: ".")[0]
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! Self
    }
    
    static func newInstance() -> Self {
        return instantiateWithStoryboard()
    }
}
