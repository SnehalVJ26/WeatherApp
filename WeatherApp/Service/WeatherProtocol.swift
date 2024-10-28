//
//  WeatherProtocol.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 15/10/24.
//

import Foundation

enum APIError: Error{
  case invalidURL
  case invalidResponse
}

protocol WeatherProtocol{
  func getWeatherDetailsForCity(name: String, completion: @escaping (Result<WeatherModel, APIError>) -> Void) async
  func getWeatherDetailsForLatLong(lat: Double, long: Double, completion: @escaping (Result<WeatherModel, APIError>) -> Void) async
}
