//
//  DarkSkyApiClient.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation

class DarkSkyApiClient {
    fileprivate let apiKeyDarkSky = "4cb418bb54aa70da51742e395c441723"
    
    lazy var baseURL : URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKeyDarkSky)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherTypeCompletionHandler = (CurrentWeather? , DarkSkyError?) -> Void
    typealias  WeatherCompletionHandler = (Weather?, DarkSkyError?) -> Void
    
    private func getWeather(at coordinate : Coordinate, completionHandler completion : @escaping WeatherCompletionHandler) { // gelen havadurumu bilgisini almayı hedefliyor.
     
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else { // coordinate.swift'te tanımladığımız descriptiondan aldı
            completion(nil, DarkSkyError.invalidURL) // hata varsa veri boş, nil. ardından hata enum'dan türetildi.
            return
        }
        let requestURL = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: requestURL) { json, error in // öncelikle json, sonra error. json var mı? eğer varsa Weather class'ındaki json parametresi olarak gönderebiliriz.
            
            guard let json = json else { // eğer bu ifade doğruysa json nesnesi mevcuta geçer.
                completion(nil, error)
                return
            }
            
            //json nesnesi mevcut. fakat currently olanı çekebilecek miyiz?
        
            guard let weather = Weather(json: json) else {
                completion(nil , DarkSkyError.JSONParsingError)
                return
            }
            
            // 2 guard let yapısında da sorun çıkmadıysa veriler sorunsuzdur demektir.
            
            completion(weather, nil) // weather nesnesini , hata olmadığı için de nil ifadesini gönderdik.
        }
        task.resume()
    }
    func getCurrentWeather(at coordinate : Coordinate, completionHandler completion : @escaping CurrentWeatherTypeCompletionHandler) {
        getWeather(at: coordinate) { weather, error in // nerden alsın? at ile coordinate : Coordinate
            completion(weather?.currently,error)
        }
        
    }
    
}
