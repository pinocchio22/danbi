//
//  WeeklyViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import Foundation

class weeklyViewModel {
    private let networkService = NetworkService()

    var dayOfWeekDic: Observable<[String: [WeeklyWeather]]> = Observable([:])

    func getWeeklyWeather() {
        networkService.getWeeklyWeather(cityName: "Uijeongbu-si") { weather in
            weather?.list.forEach {
                if self.dayOfWeekDic.value[$0.dt.unixToDay()] != nil {
                    self.dayOfWeekDic.value[$0.dt.unixToDay()]?.append(WeeklyWeather(date: $0.dt.unixToDay(),timeStamp: $0.dtTxt, maxTemp: $0.main.tempMax, minTemp: $0.main.tempMin, icon: $0.weather.first?.icon))
                } else {
                    self.dayOfWeekDic.value[$0.dt.unixToDay()] = [WeeklyWeather(date: $0.dt.unixToDay(), timeStamp: $0.dtTxt, maxTemp: $0.main.tempMax, minTemp: $0.main.tempMin, icon: $0.weather.first?.icon)]
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
