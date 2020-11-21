//
//  WeatherService.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/5/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {
    
    static let shared = WeatherService()
    private let API_KEY = APIService.shared.apiKey
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?appid=API_KEY&units=imperial"
    
    var lat = "33.441792"
    var lon = "-94.037689"
    
    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)  {
        lat = String(latitude)
        lon = String(longitude)
    }
     
    func getURL() -> String {
        let url = "\(URL_BASE)&lat=\(lat)&lon=\(lon)"
        return url
    }
    
    func getWeather(onSuccess: @escaping (WeatherData) -> Void) {
        if let url = URL(string: getURL()) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        debugPrint("Invalid data or response.")
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                            onSuccess(weatherData)
                        } else {
                            if let error = error {
                                debugPrint(error.localizedDescription)
                                return
                            }
                        }
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
}
