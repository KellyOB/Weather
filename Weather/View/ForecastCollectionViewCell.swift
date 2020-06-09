//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/8/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var forecastTimeLabel: UILabel!
    @IBOutlet weak var forecastIconImage: UIImageView!
    @IBOutlet weak var forecastTempLabel: UILabel!
    
    var weather: WeatherModel?
    
//    func updateView(hourlyForecast: Hourly) {
//        forecastTimeLabel.text = String(hourlyForecast.dt)
//        forecastIconImage.image = UIImage(systemName: "cart")
//        forecastTempLabel.text = "1"
//    }
    func updateView() {
        //forecastTimeLabel.text = "\(weather?.hourlyForecast[1].temp)"
        forecastIconImage.image = UIImage(systemName: "cart")
        forecastTempLabel.text = "2"
    }
    
    
                

    
    
}
