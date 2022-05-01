//
//  CurrentWeather.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation
import UIKit

struct CurrentWeather{
    let temperature : Double
    let precipitationProbability : Double
    let summary : String
    let humidity : Double
    let icon : String // json içinden icon olayını string olarak alıyoruz ve aşağıda icon image UI Image olarak gelen string değere göre geri döndürüyoruz.
    
    /*init(temprature : Double, precipitationProbability : Double, summary : String, humidity : Double, icon : String){
        self.temperature = temprature
        self.precipitationProbability = precipitationProbability
        self.summary = summary
        self.humidity = humidity
        self.icon = icon
    }*/
}


extension CurrentWeather{
    var iconImage : UIImage {
        switch icon {
        case "clear-day" : return #imageLiteral(resourceName: "clear-day")
        case "clear-night" : return #imageLiteral(resourceName: "clear-night")
        case "rain" : return #imageLiteral(resourceName: "rain")
        case "snow" : return #imageLiteral(resourceName: "snow")
        case "sleet" : return #imageLiteral(resourceName: "sleet")
        case "wind" : return #imageLiteral(resourceName: "wind")
        case "fog" :  return #imageLiteral(resourceName: "fog")
        case "cloudy" : return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy-day" : return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night" : return #imageLiteral(resourceName: "partly-cloudy-night")
        default : return #imageLiteral(resourceName: "default")
        }
    }
}

extension CurrentWeather{
    struct Key{
        static let temperature = "temperature"
        static let icon = "icon"
        static let summary = "summary"
        static let humidity = "humidity"
        static let precipitationProbability = "precipitationProbability"
    }
    
    init?(json : [String : AnyObject]) { // ? -> bu initi kullanmak istediğimizde hata olma olasılığı var. Terminoloji : failable initializer
        
        guard let temp = json[Key.temperature] as? Double, // eğer gelen değer double'a çevirebiliyorsak
        let iconStr = json[Key.icon] as? String, // iconu stringe çevirebiliyorsak
        let sum = json[Key.summary] as? String, // summary stringe çevrilebiliyorsa
        let hum = json[Key.humidity] as? Double, // humidty double'a çevrilebiliyorsa
        let precipProb = json[Key.precipitationProbability] as? Double else {
                return nil // değerler atanamıyorsa nil dönecektir.
        }
        
        //guard'dan geçtiyse atamaları yapacağız.
        
        self.humidity = hum
        self.temperature = (temp - 32) / 1.8 // api'de fahrenheit olan veriyi dereceye çevirdik.
        self.icon = iconStr
        self.precipitationProbability = precipProb
        self.summary = sum
    }

}


