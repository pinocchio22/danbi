//
//  WeatherCollectionViewCell.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class WeatherCollectionViewCell: UICollectionViewCell {
    // MARK: Properties

    private let timeLabel = CustomLabel(text: "시간", textColor: .black, fontSize: Util.smallFont, fontWeight: .regular)
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.min")
        return view
    }()
    
    private let tempLabel = CustomLabel(text: "온도", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    // MARK: LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method

    private func setupUI() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Util.verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(Util.verticalMargin)
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).inset(Util.verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(Util.horizontalMargin)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.bottom).inset(Util.verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(Util.horizontalMargin)
            $0.bottom.equalToSuperview().inset(Util.verticalMargin)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(100)
        }
    }
    
    func bind(time: String, icon: String, temp: String) {
        timeLabel.text = time
        tempLabel.text = temp
    }
}
