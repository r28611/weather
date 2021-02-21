//
//  WeatherService.swift
//  
//
//  Created by Margarita Novokhatskaia on 09.02.2021.
//

import UIKit
import Alamofire

class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    // Current weather
    func currentWeather(city: String, completion: @escaping (CurrentWeather) -> Void ) {
        
        AF.request(baseUrl + "/data/2.5/weather",
                   method: .get,
                   parameters: [
                    "q": city,
                    "units": "metric",
                    "appid": apiKey]).responseData { repsonse in
                        guard let data = repsonse.value else { return }
                        let weather = try! JSONDecoder().decode(CurrentWeather.self, from: data)
                        completion(weather)
                        print(weather)
                    }
    }
    
    // Call 16 day / daily forecas
    func loadWeatherForecast(city: String, for daysCount: DaysCount, completion: @escaping ([WeatherList]) -> Void ) {
        
        AF.request(baseUrl + "/data/2.5/forecast/daily",
                   method: .get,
                   parameters: [
                    "q": city,
                    "cnt": daysCount.rawValue,
                    "units": "metric",
                    "appid": apiKey]).responseData { repsonse in
                    guard let data = repsonse.value else { return }
                    let weatherList = try! JSONDecoder().decode(ForecastResponse.self, from: data).list
                    completion(weatherList)
                    print(weatherList)
                   }
    }
    
    enum DaysCount: Int {
        case one = 1
        case week = 7
        case max = 15 //max = 16
    }
    
}

