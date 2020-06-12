//
//  GradientBackground.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit

@IBDesignable

class GradientBackground: UIView {
      
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colorTop =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let colorBottom = #colorLiteral(red: 0.7960784314, green: 0.7803921569, blue: 0.8392156863, alpha: 1)
        
        self.backgroundColor = UIColor.clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.layer.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
