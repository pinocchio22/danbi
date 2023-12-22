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
                self.setCurrentWeather(newWeather: newWeather)
            }
        }
    }

    func getHourlyWeather(type: WeatherViewType) {
        if currentLocation.value != (0.0, 0.0) {
            switch type {
            case .today:
                networkService.getWeeklyWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
                    self.hourlyWeather.value = []
                    if let weather = weather {
                        let newWeather = Observable(weather).value
                        newWeather.list.filter { Date(timeIntervalSince1970: $0.dt) > Date() }.prefix(8).forEach { item in
                            self.setHourlyWeather(newWeather: newWeather, weather: item)
                            self.getCurrentWeather()
                        }
                    }
                }
            case .tomorrow:
                networkService.getWeeklyWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
                    self.hourlyWeather.value = []
                    if let weather = weather {
                        let newWeather = Observable(weather).value
                        newWeather.list.filter { Date(timeIntervalSince1970: $0.dt).convertDate(type: .day) == Date().convertDate(type: .day) + 1 }.forEach { item in
                            self.setHourlyWeather(newWeather: newWeather, weather: item)
                            self.setCurrentWeather(newWeather: newWeather, weather: item)
                        }
                    }
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
    
    private func setHourlyWeather(newWeather: WeekWeather, weather: WeekWeather.List) {
        hourlyWeather.value.append(CurrentWeather(
            id: newWeather.city.id,
            location: newWeather.city.name,
            lat: newWeather.city.coord.lat,
            lon: newWeather.city.coord.lon,
            currentTemp: weather.main.temp.setRounded(),
            maxTemp: weather.main.tempMax.setRounded(),
            minTemp: weather.main.tempMin.setRounded(),
            feelTemp: weather.main.feelsLike.setRounded(),
            timeStamp: weather.dt.unixToDate(type: .Hour),
            humidity: weather.main.humidity,
            windSpeed: weather.wind.speed,
            icon: weather.weather.first?.icon,
            description: weather.weather.first?.description ?? "날씨 정보 없음"
        ))
    }
    
    // UI전용 모델 생성
    
    private func setCurrentWeather(newWeather: TodayWeather) {
        currentWeather.value = CurrentWeather(
            id: newWeather.id,
            location: newWeather.name,
            lat: newWeather.coord.lat,
            lon: newWeather.coord.lon,
            currentTemp: newWeather.main.temp.setRounded(),
            maxTemp: newWeather.main.tempMax.setRounded(),
            minTemp: newWeather.main.tempMin.setRounded(),
            feelTemp: newWeather.main.feelsLike.setRounded(),
            timeStamp: Date().toStringDetail(),
            humidity: newWeather.main.humidity,
            windSpeed: newWeather.wind.speed,
            sunRise: newWeather.sys.sunrise,
            sunSet: newWeather.sys.sunset,
            icon: newWeather.weather.first?.icon ?? "",
            description: newWeather.weather.first?.description ?? ""
        )
    }
    
    private func setCurrentWeather(newWeather: WeekWeather, weather: WeekWeather.List) {
        currentWeather.value = CurrentWeather(
            id: newWeather.city.id,
            location: newWeather.city.name,
            lat: newWeather.city.coord.lat,
            lon: newWeather.city.coord.lon,
            currentTemp: weather.main.temp.setRounded(),
            maxTemp: weather.main.tempMax.setRounded(),
            minTemp: weather.main.tempMin.setRounded(),
            feelTemp: weather.main.feelsLike.setRounded(),
            timeStamp: Date().toStringDetail(),
            humidity: weather.main.humidity,
            windSpeed: weather.wind.speed,
            icon: weather.weather.first?.icon,
            description: weather.weather.first?.description ?? ""
        )
    }
}
