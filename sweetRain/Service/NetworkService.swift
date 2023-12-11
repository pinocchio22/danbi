//
//  NetworkService.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

import SnapKit
import Alamofire

class NetworkService {
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (TodayWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                completion(currentWeather)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getCurrentWeather(cityName: String, completion: @escaping (TodayWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        AF.request(apiUrl).responseDecodable(of: TodayWeather.self) { response in
            switch response.result {
            case .success(let currentWeather):
                completion(currentWeather)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getWeeklyWeather(lat: Double, lon: Double, completion: @escaping ([WeekWeather]?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        
        var weatherList = [WeekWeather]()
        
        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                weatherList.append(weekWeather)
                completion(weatherList)
            case .failure(let error):
                print("API 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    func getWeeklyWeather(cityName: String, completion: @escaping (WeekWeather?) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(Key.apiKey.rawValue)&units=metric&lang=kr"
        
        var weatherList = [WeekWeather]()
        AF.request(apiUrl).responseDecodable(of: WeekWeather.self) { response in
            switch response.result {
            case .success(let weekWeather):
                completion(weekWeather)
            case .failure(_):
                print("API 요청 실패")
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
