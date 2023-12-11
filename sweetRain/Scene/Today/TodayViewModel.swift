//
//  TodayViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

class TodayViewModel {
    private let networkService = NetworkService()
    var currentWeather: Observable<CurrentWeather?> = Observable(nil)
    var hourlyWeather: Observable<[CurrentWeather?]> = Observable([])
    var selectedIndex: Observable<Bool> = Observable(false)

    func getCurrentWeather() {
        networkService.getCurrentWeather(cityName: "Uijeongbu-si") { weather in
            if let weather = weather {
                let newWeather = Observable(weather).value
                self.currentWeather.value = CurrentWeather(
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
        }
    }

    func getHourlyWeather(type: WeatherViewType) {
        switch type {
        case .today:
            networkService.getWeeklyWeather(cityName: "Uijeongbu-si") { weather in
                self.hourlyWeather.value = []
                if let weather = weather {
                    let newWeather = Observable(weather).value
                    newWeather.list.filter { Date(timeIntervalSince1970: $0.dt) > Date() }.prefix(8).forEach { item in
                        self.setCurrentWeather(newWeather: newWeather, weather: item)
                    }
                }
            }
        case .tomorrow:
            networkService.getWeeklyWeather(cityName: "Uijeongbu-si") { weather in
                self.hourlyWeather.value = []
                if let weather = weather {
                    let newWeather = Observable(weather).value
                    newWeather.list.filter{ Date(timeIntervalSince1970: $0.dt).convertDate(type: .day) == Date().convertDate(type: .day) + 1 }.forEach { item in
                        self.setCurrentWeather(newWeather: newWeather, weather: item)
                    }
                }
            }
        }
    }
    
    private func setCurrentWeather(newWeather: WeekWeather, weather: WeekWeather.List) {
        self.hourlyWeather.value.append(CurrentWeather(
            id: newWeather.city.id,
            location: newWeather.city.name,
            lat: newWeather.city.coord.lat,
            lon: newWeather.city.coord.lon,
            currentTemp: weather.main.temp.setRounded(),
            maxTemp: weather.main.tempMax.setRounded(),
            minTemp: weather.main.tempMin.setRounded(),
            feelTemp: weather.main.feelsLike.setRounded(),
            timeStamp: weather.dt.unixToDate(),
            humidity: weather.main.humidity,
            windSpeed: weather.wind.speed,
            icon: weather.weather.first?.icon,
            description: weather.weather.first?.description ?? "날씨 정보 없음"
        ))
    }
}
