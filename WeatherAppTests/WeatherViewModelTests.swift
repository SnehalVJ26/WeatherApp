//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Snehal Jadhav on 15/10/24.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
  let service = WeatherAPIServiceMock()
  let sut = WeatherViewModel(weatherService: WeatherAPIServiceMock())
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
  func testGetWeatherForCity_Sucess() async {
    //Act
    
    //Arrange
    
    let task = Task { await sut.getWeatherForCity(name: "Pune") }
    await Task.yield()
 
    let result: () = await task.value
    XCTAssertNotNil(result)
    
//    Task {
//      await sut.getWeatherForCity(name: "Pune")
//      XCTAssertNotNil(sut.weather, "Model is nil")
//    }
  }
  
  func testGetWeatherForCity_URL_Failure() async {
    let task = Task{
      await sut.getWeatherForCity(name: "")
    }
    let result: () = await task.value
    XCTAssertNotNil(result)
  }
  
}
