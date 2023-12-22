//
//  SearchViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import Foundation

class SearchViewModel {
    private let networkService = NetworkService()
    private let userDefaultsService = UserDefaultsService()
    
    var filteredWeather: Observable<[[CurrentWeather]]> = Observable([[]])
    var selectedIndex: Observable<Bool> = Observable(false)
    
    var dummy = [[CurrentWeather]]()
    
    func searchWeather(cityName: String) {
        networkService.getWeeklyWeather(cityName: cityName) { weather in
            self.filteredWeather.value = []
            var weatherList: [CurrentWeather] = []
            if let weather = weather {
                let newWeather = Observable(weather).value
                newWeather.list.filter { Date(timeIntervalSince1970: $0.dt) > Date() }.prefix(8).forEach { item in
                    weatherList.append(CurrentWeather(id: weather.city.id, location: weather.city.name, lat: weather.city.coord.lat, lon: weather.city.coord.lon, currentTemp: item.main.temp, maxTemp: item.main.tempMax, minTemp: item.main.tempMin, feelTemp: item.main.feelsLike, timeStamp: item.dt.unixToDate(type: .DayHour), humidity: item.main.humidity, windSpeed: item.wind.speed, icon: item.weather.first?.icon, description: item.weather.first?.description ?? ""))
                }
                self.filteredWeather.value.append(weatherList)
            }
        }
    }
    
    func likedWeather(weather: [CurrentWeather?]) -> Bool {
        let key = weather[0]?.location ?? ""
        let value = weather.compactMap { $0 }
        if checkLikedWeather(weather: weather[0]?.location ?? "") {
            userDefaultsService.removeDefaults(key: key)
            return false
        } else {
            userDefaultsService.setUserDefaults(key: key, value: value)
            return true
        }
    }
    
    func checkLikedWeather(weather: String) -> Bool {
        return userDefaultsService.getUserDefaults(key: weather) != []
    }
    
    func getLikedWeather() -> [[CurrentWeather]] {
        return userDefaultsService.getAllData()
    }
}
