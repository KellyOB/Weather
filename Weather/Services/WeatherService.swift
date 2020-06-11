//
//  WeatherService.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/5/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)

    func onError(error: Error)
}

class WeatherService {
    
    var delegate: WeatherDelegate?
    var weather: WeatherModel?
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?appid=fb18c3a9c1c6ebf133fd0f69ba87ec46&units=imperial"
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(URL_BASE)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {

        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.onError(error: error)
                    return
                }
                if let data = data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.current.weather[0].id
            let temp = decodedData.current.temp
            let city = decodedData.timezone
            let main = decodedData.current.weather[0].description
            
            var hourlyForecast = [HourlyModel]()
            for i in 1...5 {
                let time = decodedData.hourly[i].dt
                let icon = decodedData.hourly[i].weather[0].id
                let temp = decodedData.hourly[i].temp
                
                let hourly = HourlyModel(dt: time, forecastTemp: temp, conditionId: icon)
                hourlyForecast.append(hourly)
            }
            
            var dailyForecast = [DailyModel]()
            for i in 1...5 {
                let time = Date(timeIntervalSince1970: TimeInterval(decodedData.daily[i].dt))
                
                //let time = decodedData.daily[i].dt
                let icon = decodedData.daily[i].weather[0].id
                let temp = decodedData.daily[i].temp.day
                
                let daily = DailyModel(dt: time, forecastTemp: temp, conditionId: icon)
                dailyForecast.append(daily)
                
            }
            
            weather = WeatherModel(conditionId: id, temp: temp, city: city, condition: main, hourlyForecast: hourlyForecast, dailyForecast: dailyForecast)
       
            return weather
        
        } catch {
            delegate?.onError(error: error)
            return nil
        }
    }      
}
