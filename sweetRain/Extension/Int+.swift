//
//  Int+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/12.
//

import Foundation

extension Int {
    func weekdayToKorean() -> String {
        switch self {
        case 1:
            return "일요일"
        case 2:
            return "월요일"
        case 3:
            return "화요일"
        case 4:
            return "수요일"
        case 5:
            return "목요일"
        case 6:
            return "금요일"
        case 7:
            return "토요일"
        default:
            return ""
        }
    }

    func unixToTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH시 mm분"
        return formatter.string(from: date)
    }
}
