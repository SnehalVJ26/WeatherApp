//
//  WeatherAPIServiceMock.swift
//  WeatherAppTests
//
//  Created by Snehal Jadhav on 15/10/24.
//

import Foundation
@testable import WeatherApp

class WeatherAPIServiceMock: WeatherProtocol {
  func getWeatherDetailsForLatLong(lat: Double, long: Double, completion: @escaping (Result<WeatherApp.WeatherModel, WeatherApp.APIError>) -> Void) async {
    
  }
  
  let apiKey = "317ed3f1af9ae793cd6db85716417497"

  func getWeatherDetailsForCity(name: String, completion: @escaping (Result<WeatherApp.WeatherModel, WeatherApp.APIError>) -> Void) async {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(apiKey)"
    guard let url = URL(string: urlString) else {
      completion(.failure(.invalidURL))
      return
    }
    do {
      completion(.success(mockWeatherModel()))
    } catch {
      completion(.failure(.invalidResponse))
    }
  }
  
  func mockWeatherModel() -> WeatherModel {
    return WeatherModel(name: "Test", sys: Detail(country: "Test"), weather: [Weather(icon: "Test", description: "Test")], main: Temprature(temp: 0.0, humidity: 0.0))
  }
  
}
