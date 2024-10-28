//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 14/10/24.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
  var weatherService: WeatherProtocol
  @Published var weather: WeatherModel?
  @Published var weatherIcon: String?
  @Published var showDetailView = false
  var userDefaults: UserDefaultHelper
  var locationManager: CLLocationManager =  CLLocationManager()

  init(weatherService: WeatherProtocol, weather: WeatherModel? = nil, weatherIcon: String? = nil, showDetailView: Bool = false, userDefaults: UserDefaultHelper = UserDefaultHelper.shared) {
    self.weatherService = weatherService
    self.weather = weather
    self.weatherIcon = weatherIcon
    self.showDetailView = showDetailView
    self.userDefaults = userDefaults
    self.locationManager.requestAlwaysAuthorization()
    super.init()
    self.locationManager.delegate = self
  }
  
  func getWeatherForCity(name: String) async{
    await weatherService.getWeatherDetailsForCity(name: name) { result in
      switch result {
      case .success(let model):
        DispatchQueue.main.async {
          self.weather = model
          self.saveWeatherModel(model: model)
        }
      case .failure(let error):
          print(error)
      }
    }
  }
  
  func getWeatherFromLatLong(lat: Double, long: Double) {
    Task {
      await weatherService.getWeatherDetailsForLatLong(lat: lat, long: long) { result in
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
              self.weather = model
              self.saveWeatherModel(model: model)
            }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  func getWeatherModel() {
    guard let model = userDefaults.getObject(key: "WeatherModel") else {
      return
    }
    weather = model
    showDetailView = true
  }
  
  private func saveWeatherModel(model: WeatherModel) {
    userDefaults.saveObject(model, "WeatherModel")
    showDetailView = true
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      locationManager.startUpdatingLocation()
      }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let curentLocation = locations.first else { return }
    let currentLatLong = curentLocation.coordinate
    getWeatherFromLatLong(lat: currentLatLong.latitude, long: currentLatLong.longitude)
  }
  
}

extension String {
  func localized(withComment comment: String? = nil) -> String {
    return NSLocalizedString(self, comment:comment ?? "")
  }
}
