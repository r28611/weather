//
//  Weather.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 17.02.2021.
//

import Foundation

struct ForecastResponse: Decodable {
    let list: [WeatherList]
}

struct WeatherList: Decodable {
    let dt: Double
    let sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg, clouds: Int
    let pop: Double
    let rain: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, clouds, pop, rain
    }

    struct FeelsLike: Codable {
        let day, night, eve, morn: Double
    }

    struct Temp: Codable {
        let day, min, max, night: Double
        let eve, morn: Double
    }
}

struct Weather: Codable {
    let id: Int
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
        case icon
    }
}

struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type, id: Int
        let country: String
        let sunrise, sunset: Int
    }
    
}
