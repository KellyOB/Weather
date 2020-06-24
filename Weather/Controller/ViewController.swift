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
    
    @IBOutlet var gradientBackground: GradientBackground!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayLineView: UIView!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var weeklyLineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var weatherData: WeatherData?
    var locationManager = CLLocationManager()
    
    var isToday = true {
        didSet {
            isToday ? updateToday() : updateWeekly()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        currentDateLabel.text = Date().dayStringFull()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gradientBackground.setGradientBackground()
    }
    
    func getWeather() {
        WeatherService.shared.getWeather { (weatherData) in
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
                debugPrint("hjhjkkhkjk\(weatherData)")
                self.weatherData = weatherData

                self.updateCurrentWeather()
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    func updateCurrentWeather() {
        currentLocationLabel.text = weatherData?.timezone.convertToCityName()
        currentWeatherDescriptionLabel.text = weatherData?.current.weather[0].description.capitalized
        currentWeatherIcon.image = UIImage(systemName: getIconName((weatherData?.current.weather[0].id)!))
        currentTempLabel.text = weatherData?.current.temp.tempString()
    }
    
    
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        updateToday()
    }
    
    @IBAction func weeklyButtonPressed(_ sender: UIButton) {
        updateWeekly()
    }
    
    func updateToday() {
        todayButton.isSelected = true
        weeklyButton.isSelected = false
        todayLineView.isHidden = false
        weeklyLineView.isHidden = true
        isToday = true
    }
    
    func updateWeekly() {
        todayButton.isSelected = false
        weeklyButton.isSelected = true
        todayLineView.isHidden = true
        weeklyLineView.isHidden = false
        isToday = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            if let weatherForecast = weatherData {
                if isToday {
                    let hourlyTime = weatherForecast.hourly[indexPath.row + 1].dt
                    cell.dateTimeLabel.text = hourlyTime.timeStringFromUnixTime()

                    let hourlyIcon = weatherForecast.hourly[indexPath.row + 1].weather[0].id
                    cell.iconImage.image = UIImage(systemName: self.getIconName(hourlyIcon))
                    
                    let hourlyTemp = weatherForecast.hourly[indexPath.row + 1].temp
                    cell.tempLabel.text = hourlyTemp.tempString()
                } else {
                   // let dailyDay = weatherForecast.daily[indexPath.row + 1].dt
                   // cell.dateTimeLabel.text = "ty"//dailyDay.dayStringFromUnixTime()

                   // let dailyIcon = weatherForecast.daily[indexPath.row + 1].weather[0].id
                   // cell.iconImage.image = UIImage(systemName: self.getIconName(dailyIcon))
                    
                    //let dailyTemp = weatherForecast.daily[indexPath.row + 1].temp
                    //cell.tempLabel.text = dailyTemp.tempString()
                }
                
                
            }
            return cell
        }
        return UICollectionViewCell()
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
//    func updateWeather(from weather: WeatherModel) {
//        DispatchQueue.main.async {
//            self.activityIndicatorView.startAnimating()
//            self.cityLabel.text = weather.city.convertToCityName()
//            self.currentTempLabel.text = weather.temp.tempString()
//            self.currentWeatherDescriptionLabel.text = weather.condition.capitalized
//
//            self.currentWeatherIcon.layer.shadowOffset = CGSize(width: 12, height: 12)
//            self.currentWeatherIcon.layer.shadowColor = UIColor.black.cgColor
//            self.currentWeatherIcon.layer.shadowRadius = 9
//            self.currentWeatherIcon.layer.shadowOpacity = 0.25
//            self.currentWeatherIcon.layer.masksToBounds = false
//            self.currentWeatherIcon.clipsToBounds = false
//
//            self.currentWeatherIcon.image = UIImage(systemName: self.getIconName(weather.conditionId))
//
//            if self.isToday {
//                let weatherForecast = weather.hourlyForecast
//
//                self.timeDateLabel0.text = weatherForecast[0].dt.timeStringFromUnixTime()
//                self.timeDateLabel1.text = weatherForecast[1].dt.timeStringFromUnixTime()
//                self.timeDateLabel2.text = weatherForecast[2].dt.timeStringFromUnixTime()
//                self.timeDateLabel3.text = weatherForecast[3].dt.timeStringFromUnixTime()
//                self.timeDateLabel4.text = weatherForecast[4].dt.timeStringFromUnixTime()
//
//                self.iconImage0.image = UIImage(systemName: self.getIconName(weatherForecast[0].conditionId))
//                self.iconImage1.image = UIImage(systemName: self.getIconName(weatherForecast[1].conditionId))
//                self.iconImage2.image = UIImage(systemName: self.getIconName(weatherForecast[2].conditionId))
//                self.iconImage3.image = UIImage(systemName: self.getIconName(weatherForecast[3].conditionId))
//                self.iconImage4.image = UIImage(systemName: self.getIconName(weatherForecast[4].conditionId))
//
//                self.tempLabel0.text = weatherForecast[0].forecastTemp.tempString()
//                self.tempLabel1.text = weatherForecast[1].forecastTemp.tempString()
//                self.tempLabel2.text = weatherForecast[2].forecastTemp.tempString()
//                self.tempLabel3.text = weatherForecast[3].forecastTemp.tempString()
//                self.tempLabel4.text = weatherForecast[4].forecastTemp.tempString()
//
//            } else {
//
//                let weatherForecast = weather.dailyForecast
//
//                self.timeDateLabel0.text = weatherForecast[0].dt.dayStringFromUnixTime()
//                self.timeDateLabel1.text = weatherForecast[1].dt.dayStringFromUnixTime()
//                self.timeDateLabel2.text = weatherForecast[2].dt.dayStringFromUnixTime()
//                self.timeDateLabel3.text = weatherForecast[3].dt.dayStringFromUnixTime()
//                self.timeDateLabel4.text = weatherForecast[4].dt.dayStringFromUnixTime()
//
//                self.iconImage0.image = UIImage(systemName: self.getIconName(weatherForecast[0].conditionId))
//                self.iconImage1.image = UIImage(systemName: self.getIconName(weatherForecast[1].conditionId))
//                self.iconImage2.image = UIImage(systemName: self.getIconName(weatherForecast[2].conditionId))
//                self.iconImage3.image = UIImage(systemName: self.getIconName(weatherForecast[3].conditionId))
//                self.iconImage4.image =  UIImage(systemName: self.getIconName(weatherForecast[4].conditionId))
//
//                self.tempLabel0.text = weatherForecast[0].forecastTemp.tempString()
//                self.tempLabel1.text = weatherForecast[1].forecastTemp.tempString()
//                self.tempLabel2.text = weatherForecast[2].forecastTemp.tempString()
//                self.tempLabel3.text = weatherForecast[3].forecastTemp.tempString()
//                self.tempLabel4.text = weatherForecast[4].forecastTemp.tempString()
//            }
//            self.activityIndicatorView.stopAnimating()
//        }
//    }
}

//MARK: - Weather Delegate
//extension ViewController: WeatherDelegate {
//    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
//        model = weather
//        updateWeather(from: weather)
//    }
//
//    func onError(error: Error) {
//        print(error)
//    }
//}

//MARK: - CLLocationManager Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            WeatherService.shared.getLocation(latitude: lat, longitude: lon)
            getWeather()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
