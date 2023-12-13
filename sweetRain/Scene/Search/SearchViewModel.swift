//
//  SearchViewModel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import Foundation

class SearchViewModel {
    private let networkService = NetworkService()
    
    var filterdWeather: Observable<[SearchWeather]> = Observable([])
    var selectedIndex: Observable<Bool> = Observable(false)
    
    func searchWeather(cityName: String) {
        networkService.getWeeklyWeather(cityName: cityName) { weather in
            self.filterdWeather.value = []
            var weatherList: [SearchWeather] = []
            if let weather = weather {
                let newWeather = Observable(weather).value
                newWeather.list.filter { Date(timeIntervalSince1970: $0.dt) > Date() }.prefix(8).forEach { item in
                    weatherList.append(SearchWeather(cityname: newWeather.city.name, timeStamp: item.dt.unixToweekTime(), icon: item.weather.first?.icon, temp: item.main.temp.setRounded()))
                }
                self.filterdWeather.value = weatherList
            }
        }
    }
}
