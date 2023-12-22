//
//  CustomLabel.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

class CustomLabel: UILabel {
    init(text: String, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.designHouse(size: fontSize, weight: fontWeight)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
