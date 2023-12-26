//
//  NetworkService.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

import Alamofire
import SnapKit

class NetworkService {
//    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (TodayWeather?) -> Void) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
//        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
//            switch response.result {
//            case .success(let currentWeather):
//                completion(currentWeather)
//            case .failure(let error):
//                print("API 요청 실패: \(error)")
//                completion(nil)
//            }
//        }
//    }
//
//    func getCurrentWeather(cityName: String, completion: @escaping (TodayWeather?) -> Void) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
//        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
//            switch response.result {
//            case .success(let currentWeather):
//                completion(currentWeather)
//            case .failure(let error):
//                print("API 요청 실패: \(error)")
//                completion(nil)
//            }
//        }
//    }
    
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                completion(
                    CurrentWeather(id: currentWeather.id,
                                   location: currentWeather.name,
                                   lat: currentWeather.coord.lat,
                                   lon: currentWeather.coord.lon,
                                   currentTemp: currentWeather.main.temp,
                                   maxTemp: currentWeather.main.tempMax,
                                   minTemp: currentWeather.main.tempMin,
                                   feelTemp: currentWeather.main.feelsLike,
                                   timeStamp: Date().toStringDetail(),
                                   humidity: currentWeather.main.humidity,
                                   windSpeed: currentWeather.wind.speed,
                                   icon: currentWeather.weather.first?.icon,
                                   description: currentWeather.weather.first?.description ?? "")
                )
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
//    func getCurrentWeather(cityName: String, completion: @escaping (TodayWeather?) -> Void) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
//        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
//            switch response.result {
//            case .success(let currentWeather):
//                completion(currentWeather)
//            case .failure(let error):
//                print("API 요청 실패: \(error)")
//                completion(nil)
//            }
//        }
//    }
    
    func getWeeklyWeather(lat: Double, lon: Double, completion: @escaping (WeekWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"

        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                completion(weekWeather)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getTodayWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        
        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                weekWeather.list.filter { Date(timeIntervalSince1970: $0.dt) > Date() }.prefix(8).forEach { item in
                    completion(CurrentWeather(
                        id: weekWeather.city.id,
                        location: weekWeather.city.name,
                        lat: weekWeather.city.coord.lat,
                        lon: weekWeather.city.coord.lon,
                        currentTemp: item.main.temp.setRounded(),
                        maxTemp: item.main.tempMax.setRounded(),
                        minTemp: item.main.tempMin.setRounded(),
                        feelTemp: item.main.feelsLike.setRounded(),
                        timeStamp: item.dt.unixToDate(type: .Hour),
                        humidity: item.main.humidity,
                        windSpeed: item.wind.speed,
                        icon: item.weather.first?.icon,
                        description: item.weather.first?.description ?? "날씨 정보 없음"
                    ))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getTomorrowWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        
        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                weekWeather.list.filter { Date(timeIntervalSince1970: $0.dt).convertDate(type: .day) == Date().convertDate(type: .day) + 1 }.forEach { item in
                    completion(CurrentWeather(
                        id: weekWeather.city.id,
                        location: weekWeather.city.name,
                        lat: weekWeather.city.coord.lat,
                        lon: weekWeather.city.coord.lon,
                        currentTemp: item.main.temp.setRounded(),
                        maxTemp: item.main.tempMax.setRounded(),
                        minTemp: item.main.tempMin.setRounded(),
                        feelTemp: item.main.feelsLike.setRounded(),
                        timeStamp: item.dt.unixToDate(type: .Hour),
                        humidity: item.main.humidity,
                        windSpeed: item.wind.speed,
                        icon: item.weather.first?.icon,
                        description: item.weather.first?.description ?? "날씨 정보 없음"
                    ))
                }
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getWeeklyWeather(cityName: String, completion: @escaping (WeekWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        
        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                completion(weekWeather)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getIcon(iconCode: String, completion: @escaping (Data?) -> Void) {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        DispatchQueue.global().async {
            if let iconURL = URL(string: iconURLString) {
                if let data = try? Data(contentsOf: iconURL) {
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
