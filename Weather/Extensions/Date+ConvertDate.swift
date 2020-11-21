//
//  Date+ConvertDate.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/12/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

extension Date {
    func todayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return String(dateFormatter.string(from: self))
    }
}
