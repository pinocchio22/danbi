//
//  TodayViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

class TodayViewModel {
    private let networkService = NetworkService()
    private let userDefaultsService = UserDefaultsService()
    private let locationService = LocationService()
    
    var currentWeather: Observable<CurrentWeather?> = Observable(nil)
    var hourlyWeather: Observable<[CurrentWeather?]> = Observable([])
    var hourlyWeatherCount: Int {
        return hourlyWeather.value.count
    }

    var currentLocation: Observable<(Double, Double)> = Observable((0, 0))
    var selectedIndex: Observable<Bool> = Observable(false)
    
    func getCurrentLocation() {
        locationService.startUpdating()
        locationService.currentLocation.bind { _ in
            self.currentLocation.value = self.locationService.currentLocation.value
        }
    }

    func getCurrentWeather() {
        networkService.getCurrentWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
            if let weather = weather {
                let newWeather = Observable(weather).value
                self.currentWeather.value = newWeather
            }
        }
    }
    
    func getHourlyWeather(type: WeatherViewType) {
        self.hourlyWeather.value = []
        if currentLocation.value != (0.0, 0.0) {
            switch type {
            case .today:
                networkService.getTodayWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
                    self.hourlyWeather.value.append(weather)
                    self.getCurrentWeather()
                }
            case .tomorrow:
                networkService.getTomorrowWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
                    self.hourlyWeather.value.append(weather)
                    self.currentWeather.value = weather
                }
            }
        }
    }
    
    func likedWeather(weather: [CurrentWeather?]) -> Bool {
        let key = weather[0]?.location ?? ""
        let value = weather.compactMap { $0 }
        if checkLikedWeather(weather: weather[0]) {
            userDefaultsService.removeDefaults(key: key)
            return false
        } else {
            userDefaultsService.setUserDefaults(key: key, value: value)
            return true
        }
    }
    
    func checkLikedWeather(weather: CurrentWeather?) -> Bool {
        let key = weather?.location ?? ""
        return userDefaultsService.getUserDefaults(key: key) != []
    }
    
    // UI전용 모델 생성
}
