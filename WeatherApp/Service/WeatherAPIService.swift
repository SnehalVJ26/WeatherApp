//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 14/10/24.
//

import Foundation

class WeatherAPIService: WeatherProtocol{
  let apiKey = "317ed3f1af9ae793cd6db85716417497"
  
  func getWeatherDetailsForCity(name: String, completion: @escaping (Result<WeatherModel, APIError>) -> Void) async {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(apiKey)"
    guard let url = URL(string: urlString) else {
      completion(.failure(.invalidURL))
      return
    }
    do {
      let (data,_) = try await URLSession.shared.data(from: url)
      let model = try JSONDecoder().decode(WeatherModel.self, from: data)
      completion(.success(model))
    } catch {
      completion(.failure(.invalidResponse))
    }
  }
  
  func getWeatherDetailsForLatLong(lat: Double, long: Double, completion: @escaping (Result<WeatherModel, APIError>) -> Void) async {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)"
    guard let url = URL(string: urlString) else {
      completion(.failure(.invalidURL))
      return
    }
    do {
      let (data,_) = try await URLSession.shared.data(from: url)
      let model = try JSONDecoder().decode(WeatherModel.self, from: data)
      completion(.success(model))
    } catch {
      completion(.failure(.invalidResponse))
    }
  }
  
}
