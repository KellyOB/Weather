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
                    print("there is an error here- perform request")
                    return
                }
                if let data = data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        //self.delegate?.updateView(self, weather: weather)
                        print(weather)
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
            
            var hourlyForecast = [Hourly]()
            for i in 1...5 {
                let time = decodedData.hourly[1].dt
                //let icon = decodedData.hourly[1].weather[1].id
                let temp = decodedData.hourly[1].temp
                let hourly = Hourly(dt: time, temp: temp)
                hourlyForecast.append(hourly)
            }
            
            weather = WeatherModel(conditionId: id, temp: temp, city: city, condition: main, hourlyForecast: hourlyForecast)
            print(hourlyForecast)
            //dt: dt, forecastTemp: forecastTemp, forecastId: forecastId)
            return weather
        } catch {
            delegate?.onError(error: error)
            print("error in the catch")
            return nil
        }
    }      
}
