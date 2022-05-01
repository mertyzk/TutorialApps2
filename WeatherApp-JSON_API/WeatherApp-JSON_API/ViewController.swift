//
//  ViewController.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHumidityValue: UILabel!
    
    @IBOutlet weak var lblPrecipitationValue: UILabel!
    
    @IBOutlet weak var btnRefresh: UIButton!
    
    @IBOutlet weak var lblWeatherInfo: UILabel!
    
    
    let client = DarkSkyApiClient()
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.isHidden = true
        
        locationManager.requestWhenInUseAuthorization() // uygulama açıldığında konum bilgisi izni isteyecek.
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() { // konum servisi cihazda açık mı?
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers // doğruluk payı - 3km bizim için yeterli
            locationManager.startUpdatingLocation() // konum bilgisi açılmaya başlandı
        }
    }
    
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        locationManager(locationManager, didUpdateLocations: [])
        
        
    }
    
    

}

extension ViewController{ // Functions
    
    func showWeather(model : CurrentWeatherModel){
        
        lblWeatherInfo.text = model.summary
        lblTemperature.text = model.temperature
        lblHumidityValue.text = model.humidity
        lblPrecipitationValue.text = model.precipitationProbability
        weatherIcon.image = model.icon
        indicator.stopAnimating()
    }
    
    func updateWeather(coordinate : Coordinate) {
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
            
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
            }
        }
    }
    
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("Latitude : \(clientCoordinate.latitude), Longitude : \(clientCoordinate.longitude)")
        updateWeather(coordinate: clientCoordinate)
        
    }
}

