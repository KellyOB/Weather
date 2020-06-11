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
    let hourlyForecast: [HourlyModel]
    let dailyForecast: [DailyModel]
}

struct HourlyModel {
    let dt: Double
    let forecastTemp: Double
    let conditionId: Int
}

struct DailyModel {
    let dt: Date
    let forecastTemp: Double
    let conditionId: Int
}
