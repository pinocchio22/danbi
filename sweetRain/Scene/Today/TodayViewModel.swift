//
//  TodayViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

class TodayViewModel {
    private let networkService = NetworkService()
    var currentWeather: Observable<CurrentWeather>?

    func getCurrentWeather(completion: @escaping () -> Void) {
        networkService.getCurrentWeather(cityName: "Uijeongbu-si") { weather in
            if let weather = weather {
                let weather = Observable(weather).value
                self.currentWeather = Observable(CurrentWeather(
                    id: weather.id,
                    location: weather.name,
                    lat: weather.coord.lat,
                    lon: weather.coord.lon,
                    currentTemp: weather.main.temp,
                    maxTemp: weather.main.tempMax,
                    minTemp: weather.main.tempMin,
                    feelTemp: weather.main.feelsLike,
                    timeStamp: Date().toStringDetail(),
                    humidity: weather.main.humidity,
                    windSpeed: weather.wind.speed,
                    sunRise: weather.sys.sunrise,
                    sunSet: weather.sys.sunset,
                    icon: nil,
                    description: weather.weather.first?.description ?? ""
                ))
                self.networkService.getIcon(iconCode: weather.weather.first?.icon ?? "") { icon in
                    self.currentWeather?.value.icon = icon
                }
                completion()
            }
        }
    }
}
