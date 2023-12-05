//
//  WeakWeather.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

struct WeeklyWeather {
    let id: Int
    let currentTemp: Double
    let maxTemp: Double
    let minTemp: Double
    let feelTemp: Double
    let timeStamp: String
    let discription: String
    let icon: String
}

// MARK: - WeekWeather
struct WeekWeather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
    
    // MARK: - City
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
        
        // MARK: - Coord
        struct Coord: Codable {
            let lat, lon: Double
        }

    }
    
    // MARK: - List
    struct List: Codable {
        let dt: Int
        let main: MainClass
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String
        let rain: Rain?

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
            case rain
        }
        
        // MARK: - Clouds
        struct Clouds: Codable {
            let all: Int
        }
        
        // MARK: - MainClass
        struct MainClass: Codable {
            let temp, feelsLike, tempMin, tempMax: Double
            let pressure, seaLevel, grndLevel, humidity: Int
            let tempKf: Double

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }
        
        // MARK: - Rain
        struct Rain: Codable {
            let the3H: Double

            enum CodingKeys: String, CodingKey {
                case the3H = "3h"
            }
        }
        
        // MARK: - Sys
        struct Sys: Codable {
            let pod: Pod
            
            enum Pod: String, Codable {
                case d = "d"
                case n = "n"
            }
        }
        
        // MARK: - Weather
        struct Weather: Codable {
            let id: Int
            let main: MainEnum
            let description: Description
            let icon: String
            
            enum Description: String, Codable {
                case 구름조금 = "구름조금"
                case 맑음 = "맑음"
                case 실비 = "실 비"
                case 약간의구름이낀하늘 = "약간의 구름이 낀 하늘"
                case 온흐림 = "온흐림"
                case 튼구름 = "튼구름"
            }
            
            enum MainEnum: String, Codable {
                case clear = "Clear"
                case clouds = "Clouds"
                case rain = "Rain"
            }
        }
        
        // MARK: - Wind
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
    }
}