//
//  Double+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/11.
//

import Foundation

extension Double {
    func unixToDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "HH시"
        return formatter.string(from: date)
    }
    
    func setRounded() -> Double {
        return (self * 10).rounded() / 10
    }
}
