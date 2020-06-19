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
    
    @IBOutlet var gradientBackground: GradientBackground!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayLineView: UIView!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var weeklyLineView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var timeDateLabel0:UILabel!
    @IBOutlet weak var timeDateLabel1:UILabel!
    @IBOutlet weak var timeDateLabel2:UILabel!
    @IBOutlet weak var timeDateLabel3:UILabel!
    @IBOutlet weak var timeDateLabel4:UILabel!
    
    @IBOutlet weak var iconImage0:UIImageView!
    @IBOutlet weak var iconImage1:UIImageView!
    @IBOutlet weak var iconImage2:UIImageView!
    @IBOutlet weak var iconImage3:UIImageView!
    @IBOutlet weak var iconImage4:UIImageView!
    
    @IBOutlet weak var tempLabel0:UILabel!
    @IBOutlet weak var tempLabel1:UILabel!
    @IBOutlet weak var tempLabel2:UILabel!
    @IBOutlet weak var tempLabel3:UILabel!
    @IBOutlet weak var tempLabel4:UILabel!
    
    var model: WeatherModel?
    var weatherService = WeatherService()
    var locationManager = CLLocationManager()
    
    var isToday = true {
        didSet {
            isToday ? updateToday() : updateWeekly()
        }
    }
    
    func updateToday() {
        todayButton.isSelected = true
        weeklyButton.isSelected = false
        todayLineView.isHidden = false
        weeklyLineView.isHidden = true
    }
    
    func updateWeekly() {
        todayButton.isSelected = false
        weeklyButton.isSelected = true
        todayLineView.isHidden = true
        weeklyLineView.isHidden = false
    }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gradientBackground.setGradientBackground()
    }
    
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        isToday = true
        guard let model = model else { return }
        updateWeather(from: model)
    }
    
    @IBAction func weeklyButtonPressed(_ sender: UIButton) {
        isToday = false
        guard let model = model else { return }
        updateWeather(from: model)
    }
    
    func getIconName(_ conditionId: Int) -> String {
        switch conditionId  {
        case 200...202, 230-232:
            return "cloud.bolt.rain"
        case 210...221:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 500, 511...531:
            return "cloud.rain"
        case 501...504:
            return "cloud.heavyrain"
        case 600...602, 615...622:
            return "cloud.snow"
        case 611...613:
            return "cloud.sleet"
        case 711:
            return "smoke"
        case 741:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...803:
            return "cloud.sun"
        case 804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    func updateWeather(from weather: WeatherModel) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.cityLabel.text = weather.city.convertToCityName()
            self.temperatureLabel.text = weather.temp.tempString()
            self.weatherLabel.text = weather.condition.capitalized
            
            self.weatherImage.layer.shadowOffset = CGSize(width: 12, height: 12)
            self.weatherImage.layer.shadowColor = UIColor.black.cgColor
            self.weatherImage.layer.shadowRadius = 9
            self.weatherImage.layer.shadowOpacity = 0.25
            self.weatherImage.layer.masksToBounds = false
            self.weatherImage.clipsToBounds = false
            
            self.weatherImage.image = UIImage(systemName: self.getIconName(weather.conditionId))
            
            if self.isToday {
                let weatherForecast = weather.hourlyForecast
                       
                self.timeDateLabel0.text = weatherForecast[0].dt.timeStringFromUnixTime()
                self.timeDateLabel1.text = weatherForecast[1].dt.timeStringFromUnixTime()
                self.timeDateLabel2.text = weatherForecast[2].dt.timeStringFromUnixTime()
                self.timeDateLabel3.text = weatherForecast[3].dt.timeStringFromUnixTime()
                self.timeDateLabel4.text = weatherForecast[4].dt.timeStringFromUnixTime()
               
                self.iconImage0.image = UIImage(systemName: self.getIconName(weatherForecast[0].conditionId))
                self.iconImage1.image = UIImage(systemName: self.getIconName(weatherForecast[1].conditionId))
                self.iconImage2.image = UIImage(systemName: self.getIconName(weatherForecast[2].conditionId))
                self.iconImage3.image = UIImage(systemName: self.getIconName(weatherForecast[3].conditionId))
                self.iconImage4.image = UIImage(systemName: self.getIconName(weatherForecast[4].conditionId))
                
                self.tempLabel0.text = weatherForecast[0].forecastTemp.tempString()
                self.tempLabel1.text = weatherForecast[1].forecastTemp.tempString()
                self.tempLabel2.text = weatherForecast[2].forecastTemp.tempString()
                self.tempLabel3.text = weatherForecast[3].forecastTemp.tempString()
                self.tempLabel4.text = weatherForecast[4].forecastTemp.tempString()
                
            } else {
                
                let weatherForecast = weather.dailyForecast
                
                self.timeDateLabel0.text = weatherForecast[0].dt.dayStringFromUnixTime()
                self.timeDateLabel1.text = weatherForecast[1].dt.dayStringFromUnixTime()
                self.timeDateLabel2.text = weatherForecast[2].dt.dayStringFromUnixTime()
                self.timeDateLabel3.text = weatherForecast[3].dt.dayStringFromUnixTime()
                self.timeDateLabel4.text = weatherForecast[4].dt.dayStringFromUnixTime()
                
                self.iconImage0.image = UIImage(systemName: self.getIconName(weatherForecast[0].conditionId))
                self.iconImage1.image = UIImage(systemName: self.getIconName(weatherForecast[1].conditionId))
                self.iconImage2.image = UIImage(systemName: self.getIconName(weatherForecast[2].conditionId))
                self.iconImage3.image = UIImage(systemName: self.getIconName(weatherForecast[3].conditionId))
                self.iconImage4.image =  UIImage(systemName: self.getIconName(weatherForecast[4].conditionId))
                 
                self.tempLabel0.text = weatherForecast[0].forecastTemp.tempString()
                self.tempLabel1.text = weatherForecast[1].forecastTemp.tempString()
                self.tempLabel2.text = weatherForecast[2].forecastTemp.tempString()
                self.tempLabel3.text = weatherForecast[3].forecastTemp.tempString()
                self.tempLabel4.text = weatherForecast[4].forecastTemp.tempString()
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
}

//MARK: - Weather Delegate
extension ViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        model = weather
        updateWeather(from: weather)
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
