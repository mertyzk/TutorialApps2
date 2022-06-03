//
//  ViewController.swift
//  MapKit-CLLocation
//
//  Created by Macbook Air on 3.06.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    var previousLocation : CLLocation?
    let regionSize : Double = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationServiceControl()
        goButton.layer.cornerRadius = 20
    }

    
    func locationServiceControl(){
        if CLLocationManager.locationServicesEnabled(){
            // location service opened
            locationManagerSet()
            permissionCheck()
        } else {
            
        }
    }
    
    func locationManagerSet(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func permissionCheck(){
        switch locationManager.authorizationStatus{
        case .authorizedAlways: // konum bilgisi izni kullanıcı tarafından daima olarak atanmıştır.
            break
        case .authorizedWhenInUse: // sadece uygulamayı kullanırken konum izni verilmiştir.
            followUser()
            break
        case .denied: // konum izni verilmemiş ya da reddedilmiştir.
            break
        case .notDetermined: // kullanıcı henüz karar vermemiştir.
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted: // uygulamanın durumu kısıtlanmıştır.
            break
        @unknown default:
            fatalError()
        }
    }
    
    func followUser(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        locationHold()
        previousLocation = getCenterCoordinate(mapView: mapView)
    }
    
    func locationHold() {
        if let locationn = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: locationn, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getCenterCoordinate(mapView : MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    @IBAction func goButtonClicked(_ sender: Any) {
    }
    
    

}


extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // konum guncellenirse tetiklenir
        guard let location = locations.last else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let zone = MKCoordinateRegion.init(center: center, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
        mapView.setRegion(zone, animated: true)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // konum izni değişirse
        permissionCheck()
    }
    
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterCoordinate(mapView: mapView)
        
        guard let previousLocation = self.previousLocation else { return }
        if center.distance(from: previousLocation) < 50 { return }
        self.previousLocation = center
        
        let geoCoder = CLGeocoder() // koordinat ve adres arasında dönüşüm yapar
        geoCoder.reverseGeocodeLocation(center) { placemark, error in
            if let _ = error {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            guard let placemark = placemark?.first else {
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? "Null"
            let streetName = placemark.thoroughfare ?? "Null"
            let countryNumber = placemark.country ?? "Null"
            let cityName = placemark.administrativeArea ?? "Null"
            let districtName = placemark.locality ?? "Null"
            
            DispatchQueue.main.async {
                self.adressLabel.text = "\(districtName) / \(cityName) / \(countryNumber))"
                print("Street number: \(streetNumber)")
                print("Street name: \(streetName)")
            }
            
            
            
        }
        
    }
}
