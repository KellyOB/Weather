//
//  String+ConvertCityName.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension String {
    func convertToCityName() -> String {
        let index = self.range(of: "/")?.upperBound
        let cityName = self.suffix(from: index!)
        return String(cityName).replacingOccurrences(of: "_", with: " ")
    }
}
