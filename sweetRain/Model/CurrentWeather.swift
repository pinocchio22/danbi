//
//  CurrentWeather.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

struct CurrentWeather {
    let id: Int
    let location: String
    let lat: Double
    let lon: Double
    let currentTemp: Double
    let maxTemp: Double
    let minTemp: Double
    let feelTemp: Double
    let timeStamp: String
    let humidity: Int
    let windSpeed: Double
    let sunRise: Int
    let sunSet: Int
    var icon: Data?
    let description: String
}

// MARK: - TodayWeather
struct TodayWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int
    }
    
    // MARK: - Coord
    struct Coord: Codable {
        let lon, lat: Double
    }
    
    // MARK: - Main
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity, seaLevel, grndLevel: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let type, id: Int
        let country: String
        let sunrise, sunset: Int
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int
        let main, description, icon: String
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
}
