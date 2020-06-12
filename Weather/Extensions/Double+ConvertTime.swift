//
//  Double+ConvertTime.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension Double {    
    
    func timeStringFromUnixTime() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: date as Date)
    }
}
