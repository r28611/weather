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
    
    // Hourly Forecast 4 days
    func loadWeatherForecast(city: String, completion: @escaping ([Weather]) -> Void ) {
        
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        let url = baseUrl + path
        AF.request(url, method: .get, parameters: parameters).responseData { repsonse in
            guard let data = repsonse.value else { return }
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            completion(weather)
            print(weather)
        }
    }
    
    // Current weather
    func currentWeather(city: String, completion: @escaping (Weather) -> Void ) {
        
        let path = "/data/2.5/weather"
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        let url = baseUrl + path
        AF.request(url, method: .get, parameters: parameters).responseData { repsonse in
            guard let data = repsonse.value else { return }
            let weather = try! JSONDecoder().decode(Weather.self, from: data)
            completion(weather)
            print(weather)
        }
    }
}

