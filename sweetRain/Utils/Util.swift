//
//  Util.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

enum Util {
    static let verticalMargin: CGFloat = 8
    static let horizontalMargin: CGFloat = 16

    static let largeFont: CGFloat = 36
    static let mediumFont: CGFloat = 20
    static let smallFont: CGFloat = 12

    static let largeCorner: CGFloat = 20
    static let smallCorner: CGFloat = 10

    static let mainWidth = UIScreen.main.bounds.size.width
    static let mainHeight = UIScreen.main.bounds.size.height
}

enum WeatherViewType {
    case today
    case tomorrow
}

enum CustomWeatherViewType {
    case label
    case imageView
}

enum UnixType {
    case Hour
    case Date
    case DayHour
}
