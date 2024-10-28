//
//  ContentView.swift
//  WeatherApp
//
//  Created by Snehal Jadhav on 14/10/24.
//

import SwiftUI

struct ContentView: View {
  @State var cityName: String = ""
  @StateObject var viewModel: WeatherViewModel = WeatherViewModel(weatherService: WeatherAPIService())
  
    var body: some View {
      NavigationStack {
        VStack {
          HStack{
            TextField("Enter City Name".localized(), text: $cityName)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            Button{
              Task{
                await viewModel.getWeatherForCity(name: cityName)
              }
            }label: {
              Image(systemName: "magnifyingglass.circle.fill")
                .font(.title)
            }
          }
          Spacer()
          WeatherDetailView(model: $viewModel.weather)
            .opacity(viewModel.showDetailView ? 1.0 : 0.0)
          Spacer()
        }
        .padding()
        .navigationBarTitle("Weather".localized())
        .background(.blue.opacity(0.2))
      }.onAppear{
        viewModel.getWeatherModel()
      }
      .onDisappear{
        viewModel.locationManager.stopUpdatingLocation()
      }
    }
}

struct WeatherDetailView: View{
  @Binding var model: WeatherModel?
  var iconURL = "https://openweathermap.org/img/wn/"
  
  var body: some View {
    VStack{
      HStack {
        Text("\(model?.name ?? "")")
          .font(.title)
        Text("\(model?.sys.country ?? "")")
          .font(.title2)
      }
      AsyncImage(url: URL(string: "\(iconURL)\(model?.weather[0].icon ?? "").png"))
        .frame(width: 100, height: 100)
      Text("\(model?.weather[0].description ?? "")")
        .font(.title3)
      Text("\(model?.main.humidity ?? 0.0)")
        .font(.title3)
      Text("\(model?.main.temp ?? 0.0)")
        .font(.title3)
    }
  }
}

#Preview {
    ContentView()
}
