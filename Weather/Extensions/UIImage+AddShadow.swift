//
//  UIImage+AddShadow.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/24/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit

@IBDesignable

class AddShadow: UIImageView {
    
    override func prepareForInterfaceBuilder() {
        addShadow()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }
    
    
    func addShadow() {
        layer.shadowOffset = CGSize(width: 12, height: 12)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
        clipsToBounds = false
    }
}
