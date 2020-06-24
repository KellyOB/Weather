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
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?appid=fb18c3a9c1c6ebf133fd0f69ba87ec46&units=imperial"
    
    var lat = "33.441792"
    var lon = "-94.037689"
    
    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)  {
        lat = String(latitude)
        lon = String(longitude)
    }
    
//    func getLocation()  {
//        locationManager.requestWhenInUseAuthorization()
//        var currentLoc: CLLocation!
//        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//        CLLocationManager.authorizationStatus() == .authorizedAlways) {
//           currentLoc = locationManager.location
//            url = "\(URL_BASE)&lat=\(currentLoc.coordinate.latitude)&lon=\(currentLoc.coordinate.longitude)"
//           print(currentLoc.coordinate.latitude)
//           print(currentLoc.coordinate.longitude)
//            return url
//        }
//        return "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=fb18c3a9c1c6ebf133fd0f69ba87ec46&units=imperial"
//    }
     
    func getURL() -> String {
        let url = "\(URL_BASE)&lat=\(lat)&lon=\(lon)"
        return url
    }
    
    let session = URLSession(configuration: .default)
 
    func getWeather(onSuccess: @escaping (WeatherData) -> Void) {
       //getLocation()
        let url = URL(string: getURL())!
        print("print url from getweather \(url)")
        
        // task automatically gets callef in in background
         let task = session.dataTask(with: url) { (data, response, error) in
            
            // once request is filled brings to main thread
            DispatchQueue.main.async {
                if let error = error {
                    debugPrint("task:\(error.localizedDescription)")
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    debugPrint("Invalid data or response.")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        // parse successful result
                        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                        // handle success
                        onSuccess(weatherData)
                        
                        
                    } else {
                        // show error to user
                        
                        // handle error
                    }
                } catch {                    debugPrint("getWeather:\(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}


//protocol WeatherDelegate {
//    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
//
//    func onError(error: Error)
//}
//
//class WeatherService {
//
//    var delegate: WeatherDelegate?
//    var weather: WeatherModel?
//
//    let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?appid=fb18c3a9c1c6ebf133fd0f69ba87ec46&units=imperial"
//
//    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(URL_BASE)&lat=\(latitude)&lon=\(longitude)"
//        performRequest(with: urlString)
//    }
//
//    func performRequest(with urlString: String) {
//
//        if let url = URL(string: urlString) {
//
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    self.delegate?.onError(error: error)
//                    return
//                }
//                if let data = data {
//                    if let weather = self.parseJSON(data) {
//                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.current.weather[0].id
//            let temp = decodedData.current.temp
//            let city = decodedData.timezone
//            let main = decodedData.current.weather[0].description
//
//            var hourlyForecast = [HourlyModel]()
//            for i in 1...5 {
//                let time = decodedData.hourly[i].dt
//                let icon = decodedData.hourly[i].weather[0].id
//                let temp = decodedData.hourly[i].temp
//
//                let hourly = HourlyModel(dt: time, forecastTemp: temp, conditionId: icon)
//                hourlyForecast.append(hourly)
//            }
//
//            var dailyForecast = [DailyModel]()
//            for i in 1...5 {
//                let time = Date(timeIntervalSince1970: TimeInterval(decodedData.daily[i].dt))
//
//                let icon = decodedData.daily[i].weather[0].id
//                let temp = decodedData.daily[i].temp.day
//
//                let daily = DailyModel(dt: time, forecastTemp: temp, conditionId: icon)
//                dailyForecast.append(daily)
//            }
//
//            weather = WeatherModel(conditionId: id, temp: temp, city: city, condition: main, hourlyForecast: hourlyForecast, dailyForecast: dailyForecast)
//
//            return weather
//
//        } catch {
//            delegate?.onError(error: error)
//            return nil
//        }
//    }
//}
