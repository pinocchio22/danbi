//
//  Double+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/11.
//

import Foundation

extension Double {
    func unixToDate(type: UnixType) -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_KR")

        switch type {
        case .Date:
            formatter.dateFormat = "EEEE"
        case .DayHour:
            formatter.dateFormat = "dd일 HH시"
        case .Hour:
            formatter.dateFormat = "HH시"
        }

        return formatter.string(from: date)
    }

    func setRounded() -> Double {
        return (self * 10).rounded() / 10
    }
}
