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
    
//    func updateView(hourlyForecast: HourlyModel) {
//        forecastTimeLabel.text = String(hourlyForecast.dt)
//        forecastIconImage.image = UIImage(systemName: "cart")
//        forecastTempLabel.text = "1"
//    }
    
    
    
    
    func updateView(dailyForecast: DailyModel) {
        let tf = DateFormatter()
        tf.dateStyle = .full
        //let strDate = tf.string(from: dailyForecast.dt)
       // let dateParts = strDate.split(separator: ",")
       // let dayOfWeek = String(dateParts[0])
        
//        forecastTimeLabel.text = dayOfWeek
//        forecastIconImage.image = UIImage(systemName: dailyForecast.conditionId)
//        forecastTempLabel.text = String(format: "%.1f", dailyForecast.forecastTemp)
    }
    
    
                

    
    
}
