//
//  WeeklyViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

class weeklyViewModel {
    private let networkService = NetworkService()
    private let locationService = LocationService()

    var dayOfWeekDic: Observable<[String: [WeeklyWeather]]> = Observable([:])
    var currentLocation: Observable<(Double, Double)> = Observable((0,0))
    
    func getCurrentLocation() {
        self.locationService.startUpdating()
        self.locationService.currentLocation.bind {_ in
            self.currentLocation.value = self.locationService.currentLocation.value
        }
    }

    func getWeeklyWeather() {
        networkService.getWeeklyWeather(lat: currentLocation.value.0, lon: currentLocation.value.1) { weather in
            weather?.list.forEach {
                if self.dayOfWeekDic.value[$0.dt.unixToDate(type: .Date)] != nil {
                    self.dayOfWeekDic.value[$0.dt.unixToDate(type: .Date)]?.append(WeeklyWeather(date: $0.dt.unixToDate(type: .Date),timeStamp: $0.dtTxt, maxTemp: $0.main.tempMax, minTemp: $0.main.tempMin, icon: $0.weather.first?.icon))
                } else {
                    self.dayOfWeekDic.value[$0.dt.unixToDate(type: .Date)] = [WeeklyWeather(date: $0.dt.unixToDate(type: .Date), timeStamp: $0.dtTxt, maxTemp: $0.main.tempMax, minTemp: $0.main.tempMin, icon: $0.weather.first?.icon)]
                }
            }
        }
    }

    func getMaxMinTemp() -> [WeeklyWeather] {
        var result: [WeeklyWeather] = []
        for (_, weathers) in dayOfWeekDic.value {
            if let lastWeather = weathers.last {
                result.append(lastWeather)
            }
        }
        result.sort(by: { $0.timeStamp < $1.timeStamp })
        return result
    }
}
