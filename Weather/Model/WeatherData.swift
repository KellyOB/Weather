//
//  Forecast.swift
//  WeatherData
//
//  Created by Kelly O'Brien on 6/5/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit

struct WeatherData: Codable {
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let temp: Double
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let description: String
    
    var icon: UIImage? {
        return UIImage(systemName: getIconName(id))
    }
    
    func getIconName(_ conditionId: Int) -> String {
        switch conditionId  {
        case 200...202, 230-232:
            return "cloud.bolt.rain"
        case 210...221:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 500, 511...531:
            return "cloud.rain"
        case 501...504:
            return "cloud.heavyrain"
        case 600...602, 615...622:
            return "cloud.snow"
        case 611...613:
            return "cloud.sleet"
        case 711:
            return "smoke"
        case 741:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...803:
            return "cloud.sun"
        case 804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Double
    let temp: TempData
    let weather: [Weather]
}

struct TempData: Codable {
    let day: Double
}
