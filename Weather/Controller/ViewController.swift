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
    
    var isToday = true
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        currentDateLabel.text = Date().todayString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gradientBackground.setGradientBackground()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func getWeather() {
        WeatherService.shared.getWeather { (weatherData) in
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
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
        currentWeatherIcon.image = weatherData?.current.weather[0].icon
        currentTempLabel.text = weatherData?.current.temp.tempString()
    }
        
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        isToday = true
        todayButton.isSelected = true
        weeklyButton.isSelected = false
        todayLineView.isHidden = false
        weeklyLineView.isHidden = true
        collectionView.reloadData()
    }
    
    @IBAction func weeklyButtonPressed(_ sender: UIButton) {
        isToday = false
        todayButton.isSelected = false
        weeklyButton.isSelected = true
        todayLineView.isHidden = true
        weeklyLineView.isHidden = false
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            if let weatherForecast = weatherData {
                if isToday {
                    let hourly = weatherForecast.hourly[indexPath.row + 1]
                    
                    cell.configure(hour: hourly)
                    
                } else {
                    let daily = weatherForecast.daily[indexPath.row + 1]
                
                    cell.configure(day: daily)
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
}

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

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // number of columns desired
        let columns: CGFloat = 5
        
        // Match spacing below
        let spacing: CGFloat = 5
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // horizontal space between items
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // vertical space between items
        return 5
    }
}

