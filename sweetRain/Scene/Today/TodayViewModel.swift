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
    var hourlyWeather: Observable<[WeeklyWeather?]> = Observable([])

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

    func getHourlyWeather(type: hourlyWeather) {
        networkService.getWeeklyWeather(cityName: "Uijeongbu-si") { weather in
            if let weather = weather {
                let newWeather = Observable(weather).value
                for i in 0...8 {
                    let item = newWeather.list[i]
                    self.hourlyWeather.value.append(WeeklyWeather(
                        currentTemp: item.main.temp.setRounded(),
                        maxTemp: item.main.tempMax.setRounded(),
                        minTemp: item.main.tempMin.setRounded(),
                        feelTemp: item.main.feelsLike.setRounded(),
                        timeStamp: item.dt.unixToDate(),
                        discription: item.weather.first?.description ?? "",
                        icon: item.weather.first?.icon ?? ""
                    ))
                }
            }
        }
    }

    enum hourlyWeather {
        case today
        case tomorrow
    }
}
