//
//  UserDefaultsService.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/14.
//

import Foundation

class UserDefaultsService {
    let defaults = UserDefaults.standard
    
    func setUserDefaults(key: String, value: [CurrentWeather]) {
        if let encodedData = try? JSONEncoder().encode(value) {
            defaults.set(encodedData, forKey: key)
        }
    }
    
    func getUserDefaults(key: String) -> [CurrentWeather] {
        if let savedData = defaults.data(forKey: key) {
            if let loadedObject = try? JSONDecoder().decode([CurrentWeather].self, from: savedData) {
                return loadedObject
            }
        }
        return []
    }
    
    func removeDefaults(key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func getAllData() -> [[CurrentWeather]] {
        let allData = defaults.dictionaryRepresentation()
        
        var allList = [[CurrentWeather]]()
        
        for (_, value) in allData {
            if let data = value as? Data {
                if let weather = try? JSONDecoder().decode([CurrentWeather].self, from: data) {
                    allList.append(weather)
                }
            }
        }
        return allList
    }
}
