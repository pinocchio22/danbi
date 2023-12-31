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

    private let timeLabel = CustomLabel(text: "시간", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold)
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.min")
        return view
    }()
    
    private let tempLabel = CustomLabel(text: "온도", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold)
    
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
        addSubview(timeLabel)
        addSubview(weatherIcon)
        addSubview(tempLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Util.verticalMargin)
            $0.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).inset(-Util.verticalMargin)
            $0.size.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.bottom).inset(-Util.verticalMargin)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Util.verticalMargin)
        }
    }
    
    func bind(time: String, icon: String, temp: String) {
        timeLabel.text = time
        weatherIcon.setIcon(icon: icon)
        tempLabel.text = "\(temp)℃"
    }
}
