//
//  CustomWeatherView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class CustomWeatherView: UIView {
    // MARK: Properties
    var titleLabel: CustomLabel?
    var height: CGFloat = 0
    
    // MARK: LifeCycle
    init(title: String, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight, viewHeight: CGFloat) {
        super.init(frame: .zero)
        self.titleLabel = CustomLabel(text: title, textColor: textColor, fontSize: fontSize, fontWeight: fontWeight)
        self.height = viewHeight
        self.backgroundColor = .customSkyblue
        self.layer.cornerRadius = Util.largeCorner
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    private func setupUI() {
        guard let titleLabel = titleLabel else { return }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
