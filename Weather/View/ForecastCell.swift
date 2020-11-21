//
//  ForecastCell.swift
//  Weather
//
//  Created by Kelly O'Brien on 6/23/20.
//  Copyright © 2020 Kismet Development. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(hour: Hourly) {
        dateTimeLabel.text = hour.dt.timeStringFromUnixTime()
        iconImage.image = hour.weather[0].icon
        tempLabel.text = hour.temp.tempString()
    }
    
    func configure(day: Daily) {
        dateTimeLabel.text = day.dt.dayStringFromUnixTime(day.dt)
        iconImage.image = day.weather[0].icon
        tempLabel.text = day.temp.day.tempString()
    }  
}
