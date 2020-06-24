//
//  Double+ConvertDay.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/24/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension Double {
    
    func dayStringFromUnixTime(_ timeStamp: Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .full
        
        let fullDate = dayFormatter.string(from: date as Date)
        let day = fullDate.split(separator: ",")
        
        return String(String(day[0]).prefix(3))
    }
}
