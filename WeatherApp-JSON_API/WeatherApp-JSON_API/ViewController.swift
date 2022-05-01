//
//  ViewController.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHumidityValue: UILabel!
    
    @IBOutlet weak var lblPrecipitationValue: UILabel!
    
    @IBOutlet weak var btnRefresh: UIButton!
    
    @IBOutlet weak var lblWeatherInfo: UILabel!
    
    
    let client = DarkSkyApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getCurrentWeather(at: Coordinate.alcatrazIsland) { currentWeather, error in
            
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.async {
                    self.showWeather(model: viewModel)
                }
            }
            
        }
        
    }

}

extension ViewController{ // Functions
    
    func showWeather(model : CurrentWeatherModel){
        
        lblWeatherInfo.text = model.summary
        lblTemperature.text = model.temperature
        lblHumidityValue.text = model.humidity
        lblPrecipitationValue.text = model.precipitationProbability
        weatherIcon.image = model.icon
        
    }
    
}
