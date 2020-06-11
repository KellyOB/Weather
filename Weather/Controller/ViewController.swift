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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var timeDateLabel1:UILabel!
    @IBOutlet weak var timeDateLabel2:UILabel!
    @IBOutlet weak var timeDateLabel3:UILabel!
    @IBOutlet weak var timeDateLabel4:UILabel!
    @IBOutlet weak var timeDateLabel5:UILabel!
    
    @IBOutlet weak var iconImage1:UIImageView!
    @IBOutlet weak var iconImage2:UIImageView!
    @IBOutlet weak var iconImage3:UIImageView!
    @IBOutlet weak var iconImage4:UIImageView!
    @IBOutlet weak var iconImage5:UIImageView!
    
    @IBOutlet weak var tempLabel1:UILabel!
    @IBOutlet weak var tempLabel2:UILabel!
    @IBOutlet weak var tempLabel3:UILabel!
    @IBOutlet weak var tempLabel4:UILabel!
    @IBOutlet weak var tempLabel5:UILabel!
    
    var weatherService = WeatherService()
    var locationManager = CLLocationManager()
    var isToday = true
    
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
        
        if isToday {
            todayButton.tintColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            weeklyButton.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            todayButton.tintColor = #colorLiteral(red: 0.6551536711, green: 0.6574564995, blue: 0.6643649846, alpha: 1)
            weeklyButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        isToday = true
        todayButton.tintColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            weeklyButton.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
       
            
        self.viewDidLoad()
    }
    @IBAction func weeklyButtonPressed(_ sender: UIButton) {
        isToday = false
        todayButton.tintColor = #colorLiteral(red: 0.6551536711, green: 0.6574564995, blue: 0.6643649846, alpha: 1)
        weeklyButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.viewDidLoad()
    }
}

//MARK: - Weather Delegate
extension ViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.cityLabel.text = weather.city.convertToCityName()
            
            self.temperatureLabel.text = weather.temp.tempString()
            self.weatherLabel.text = weather.condition.capitalized
            self.weatherImage.image = UIImage(systemName: weather.conditionIcon)
            
            if self.isToday {
                let weatherForecast = weather.hourlyForecast
                self.timeDateLabel1.text = weatherForecast[0].dt.timeStringFromUnixTime()
                self.timeDateLabel2.text = weatherForecast[1].dt.timeStringFromUnixTime()
                self.timeDateLabel3.text = weatherForecast[2].dt.timeStringFromUnixTime()
                self.timeDateLabel4.text = weatherForecast[3].dt.timeStringFromUnixTime()
                self.timeDateLabel5.text = weatherForecast[4].dt.timeStringFromUnixTime()
                
                self.iconImage1.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage2.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage3.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage4.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage5.image = UIImage(systemName: weather.conditionIcon)
                
                self.tempLabel1.text = weatherForecast[0].forecastTemp.tempString()
                self.tempLabel2.text = weatherForecast[1].forecastTemp.tempString()
                self.tempLabel3.text = weatherForecast[2].forecastTemp.tempString()
                self.tempLabel4.text = weatherForecast[3].forecastTemp.tempString()
                self.tempLabel5.text = weatherForecast[4].forecastTemp.tempString()
            } else {
                let weatherForecast = weather.dailyForecast
                
                self.timeDateLabel1.text = weatherForecast[0].dt.dayStringFromUnixTime()
                self.timeDateLabel2.text = weatherForecast[1].dt.dayStringFromUnixTime()
                self.timeDateLabel3.text = weatherForecast[2].dt.dayStringFromUnixTime()
                self.timeDateLabel4.text = weatherForecast[3].dt.dayStringFromUnixTime()
                self.timeDateLabel5.text = weatherForecast[4].dt.dayStringFromUnixTime()
                
                self.iconImage1.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage2.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage3.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage4.image = UIImage(systemName: weather.conditionIcon)
                self.iconImage5.image = UIImage(systemName: weather.conditionIcon)
                
                self.tempLabel1.text = weatherForecast[0].forecastTemp.tempString()
                self.tempLabel2.text = weatherForecast[1].forecastTemp.tempString()
                self.tempLabel3.text = weatherForecast[2].forecastTemp.tempString()
                self.tempLabel4.text = weatherForecast[3].forecastTemp.tempString()
                self.tempLabel5.text = weatherForecast[4].forecastTemp.tempString()
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func onError(error: Error) {
        print(error)
    }
    
    // var weather: WeatherModel?
    // would go in cell for row at.
    //    cell.updateView(dailyForecast: weather!.dailyForecast[indexPath.row])
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
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: date as Date)
    }
}

extension Date {
    func dayStringFromUnixTime() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .full
        let fullDate = dayFormatter.string(from: self)
        let day = fullDate.split(separator: ",")
        return String(day[0])
    }
}

extension String {
    func convertToCityName() -> String {
        let index = self.range(of: "/")?.upperBound
        let cityName = self.suffix(from: index!)
        return String(cityName).replacingOccurrences(of: "_", with: " ")
    }
}
