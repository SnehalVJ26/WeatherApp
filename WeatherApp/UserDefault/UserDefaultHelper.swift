//
//  UserDefaultHelper.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 15/10/24.
//

import Foundation

class UserDefaultHelper: NSObject{
  static let shared = UserDefaultHelper()
  private override init() {
    
  }
  func saveObject(_ value:WeatherModel, _ key:String){
    UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    UserDefaults.standard.synchronize()
  }
  func getObject(key:String) -> WeatherModel?{
    guard let data = UserDefaults.standard.value(forKey: key) as? Data,
    let userData = try? PropertyListDecoder().decode(WeatherModel.self, from: data)
    else { return nil}
    return userData
  }
}
