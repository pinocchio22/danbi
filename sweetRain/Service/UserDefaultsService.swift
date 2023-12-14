//
//  UserDefaultsService.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/14.
//

import Foundation

class UserDefaultsService {
    let defaults = UserDefaults.standard
    
    func setUserDefaults(key: String, value: String) {
        defaults.set(value, forKey: key)
    }
    
    func getUserDefaults(key: String) {
        defaults.string(forKey: key)
    }
}
