//
//  UIFont+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

extension UIFont {
    static func d2cording(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName = "D2Coding"

        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bold"
        case .regular:
            weightString = "Regular"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(fontName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
