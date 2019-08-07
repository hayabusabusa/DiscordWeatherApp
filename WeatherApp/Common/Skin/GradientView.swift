//
//  GradientView.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/07.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .clear
    @IBInspectable var endColor: UIColor = .white
    @IBInspectable var startPoint: CGPoint = .init(x: 0.5, y: 0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    @IBInspectable var endPoint: CGPoint = .init(x: 0.5, y: 1) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
