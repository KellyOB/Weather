//
//  WeatherModel.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/5/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let temp: Double
    let city: String
    let condition: String
    let hourlyForecast: [Hourly]
//    let dt: Double
//    let forecastTemp: Double
//    let forecastId: Int
    
    var conditionIcon: String {
        switch (conditionId, conditionId)  {
        case (200...232, 200...232):
            return "cloud.bolt"
        case (300...321, 300...321):
            return "cloud.drizzle"
        case (500...531, 500...531):
            return "cloud.rain"
        case (600...622, 600...622):
            return "cloud.snow"
        case (741, 741):
            return "cloud.fog"
        case (800, 800):
            return "sun.max"
        case (801...804, 801...804):
            return "cloud"
        default:
            return "cloud"
        }
    }
}
