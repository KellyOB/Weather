//
//  Forecast.swift
//  WeatherData
//
//  Created by Kelly O'Brien on 6/5/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let timezone: String
    let current: Current
    //let hourly: Hourly
   // let daily: Daily
    
    
}

struct Current: Codable {
    let temp: Double
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let description: String
}

//struct Hourly: Codable {
//    let dt: Int
//    let temp: Double
//    let weather: [Weather]
//}
//
//struct Daily: Codable {
//    let dt: Int
//    let temp: [Temp]
//    let weather: [Weather]
//}

struct Temp: Codable {
    let day: Double
}
