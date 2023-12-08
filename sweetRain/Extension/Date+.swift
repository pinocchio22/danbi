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
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
