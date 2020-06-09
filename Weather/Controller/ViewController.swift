//
//  ViewController.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/4/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherService = WeatherService()
    var locationManager = CLLocationManager()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
    
    //MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let hourlyForcast = WeatherService.weather
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCollectionViewCell {
            
            //cell.forecastIconImage.image = icon
            //let forecast = WeatherService.getWeather(<#T##self: WeatherService##WeatherService#>)[indexPath.row]
            //cell.updateView(with: forecast)
                
            return cell
        }
        return ForecastCollectionViewCell()
            
    //        forecastWeatherImage1.image = UIImage(systemName: weather.conditionIcon)
    //
    //        forcastTimeDate1.text =  weather.dt.timeStringFromUnixTime()
    //
    //        forecastTemperatureLabel1.text = weather.hour1Temp.tempString()
    }
}

//MARK: - Weather Delegate
extension ViewController: WeatherDelegate {
    
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.updateCurrentWeather(weatherService, weather: weather)
//            self.cityLabel.text = weather.city.convertToCityName()
//
//            self.temperatureLabel.text = weather.temp.tempString()
//            self.weatherLabel.text = weather.condition.capitalized
//            self.weatherImage.image = UIImage(systemName: weather.conditionIcon)

//            let time = weather.dt.timeStringFromUnixTime()
//            let icon = UIImage(systemName: weather.conditionIcon)
//            let temp = weather.temp.tempString()
            
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func updateCurrentWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        self.cityLabel.text = weather.city.convertToCityName()

        self.temperatureLabel.text = weather.temp.tempString()
        self.weatherLabel.text = weather.condition.capitalized
        self.weatherImage.image = UIImage(systemName: weather.conditionIcon)
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

extension Double {
    func tempString() -> String {
        return String(format: "%.1f", self) + "°"
    }
    
    func timeStringFromUnixTime() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: date as Date)
    }
}

extension String {
    func convertToCityName() -> String {
        let index = self.range(of: "/")?.upperBound
        let cityName = self.suffix(from: index!)
        return String(cityName).replacingOccurrences(of: "_", with: " ")
    }
}


