//
//  Date+ConvertDate.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension Date {
    func dayStringFromUnixTime() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .full
        let fullDate = dayFormatter.string(from: self)
        let day = fullDate.split(separator: ",")
        
        return String(String(day[0]).prefix(3))
    }
}
