//
//  CurrentWeatherModel.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation
import UIKit

struct CurrentWeatherModel{
    let summary : String
    let icon : UIImage
    let temperature : String
    let humidity : String
    let precipitationProbability : String
    // temperature, humidty vs json icerisinde double olarak gelecek fakat bizim model icinde string olarak elde etmemiz yeterli
    
    init(data : CurrentWeather){
        
        self.summary = data.summary
        self.icon = data.iconImage
        self.precipitationProbability = "%\(Int(data.precipitationProbability * 100))"
        self.temperature = "\(Int(data.temperature))°"
        self.humidity = "%\(Int(data.humidity*100))"
        
    }
}
