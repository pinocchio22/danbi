//
//  Date+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/08.
//

import Foundation

extension Date {
    func toStringDetail() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }

    func convertDate(type: Calendar.Component) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        let dateComponents = calendar.dateComponents([type], from: self)
        switch type {
        case .day:
            if let day = dateComponents.day {
                return day
            }
        case .month:
            if let month = dateComponents.month {
                return month
            }
        case .year:
            if let year = dateComponents.year {
                return year
            }
            
        case .hour:
            if let hour = dateComponents.hour {
                return hour
            }
        default: return 0
        }

        return 0
    }
}
