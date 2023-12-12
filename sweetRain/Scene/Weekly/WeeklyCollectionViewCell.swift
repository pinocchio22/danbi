//
//  WeeklyCollectionViewCell.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

class WeeklyCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    
    private let dayLabel = CustomLabel(text: "요일", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.min")
        return view
    }()
    
    private let tempLabel = CustomLabel(text: "최고 / 최저", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    // MARK: LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method

    private func setupUI() {
        addSubview(dayLabel)
        addSubview(weatherIcon)
        addSubview(tempLabel)
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Util.horizontalMargin)
            $0.centerY.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).inset(-Util.horizontalMargin).priority(3)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        tempLabel.snp.makeConstraints {
            $0.leading.equalTo(weatherIcon.snp.trailing).inset(-Util.horizontalMargin).priority(2)
            $0.trailing.equalToSuperview().inset(Util.horizontalMargin).priority(1)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .customSkyblue
        self.layer.cornerRadius = Util.smallCorner
    }
    
    func bind(day: String, icon: String, max: Double, min: Double) {
        dayLabel.text = day
        weatherIcon.setIcon(icon: icon)
        tempLabel.text = "최저:\(min) / 최고:\(max)"
    }
}
