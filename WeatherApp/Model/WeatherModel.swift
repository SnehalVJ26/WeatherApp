//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 14/10/24.
//

import Foundation

struct WeatherModel: Codable, Equatable {
  var name: String
  var sys: Detail
  var weather: [Weather]
  var main: Temprature
}

struct Detail: Codable, Equatable{
  var country: String
}

struct Weather: Codable, Equatable{
  var icon: String
  var description: String
}

struct Temprature: Codable, Equatable{
  var temp: Double
  var humidity: Double
}

/*
{
  "coord": {
    "lon": -0.1257,
    "lat": 51.5085
  },
  "weather": [
    {
      "id": 804,
      "main": "Clouds",
      "description": "overcast clouds",
      "icon": "04d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 284.79,
    "feels_like": 284.36,
    "temp_min": 284.02,
    "temp_max": 285.72,
    "pressure": 1015,
    "humidity": 90,
    "sea_level": 1015,
    "grnd_level": 1011
  },
  "visibility": 10000,
  "wind": {
    "speed": 7.2,
    "deg": 90
  },
  "clouds": {
    "all": 100
  },
  "dt": 1728916266,
  "sys": {
    "type": 2,
    "id": 2075535,
    "country": "GB",
    "sunrise": 1728886985,
    "sunset": 1728925766
  },
  "timezone": 3600,
  "id": 2643743,
  "name": "London",
  "cod": 200
}
*/
