//
//  ViewController.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/4/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    
    @IBOutlet weak var forcastTimeDate1: UILabel!
    @IBOutlet weak var forecastWeatherImage1: UIImageView!
    @IBOutlet weak var forecastTemperatureLabel1: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var weatherService = WeatherService()
    var locationManager = CLLocationManager()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
         
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let today = "\(dateFormatter.string(from: Date() as Date))"
        dateLabel.text = String(today)
        
        print(today)
    }
}

//MARK: - Weather Delegate
extension ViewController: WeatherDelegate {
    
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            
            let city = weather.city
            if let index = city.range(of: "/")?.upperBound {
                let cityName = city.suffix(from: index)

                self.cityLabel.text = String(cityName).replacingOccurrences(of: "_", with: " ")
            } else {
                self.cityLabel.text = city
            }

            self.temperatureLabel.text = weather.temperatureString
            self.weatherLabel.text = weather.condition.capitalized
            self.weatherImage.image = UIImage(systemName: weather.conditionIcon)
    
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func onError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManager Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherService.getWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//extension String {
//    func chopPrefix(_ count: UInt = 1) -> String {
//
//
//        return String(suffix(from: index(startIndex, offsetBy: Int(count))))
//    }
//}
