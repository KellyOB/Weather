//
//  Double+ConvertTemp.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension Double {
    
    func tempString() -> String {
        return String(format: "%.1f", self) + "°"
    }
}
