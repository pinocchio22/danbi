//
//  UIFont+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

extension UIFont {
    static func designHouse(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        var fontName: String
        switch weight {
        case .bold:
            fontName = "designhouseBold"
        case .regular:
            fontName = "designhouseLight"
        default:
            fontName = "designhouseLight"
        }

        return UIFont(name: fontName, size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
