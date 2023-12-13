//
//  TodayView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class TodayView: UIView {
    // MARK: Properties
    
//    private let selectDayView = CustomSegmentedControllerView(firstTitle: "오늘", secondTitle: "내일")
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let contentView = UIView()
    
    lazy var todayStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleStackView, weatherIcon, currentTempLabel, timeLabel, maxminTempLabel])
        view.axis = .vertical
        view.spacing = Util.verticalMargin
        view.alignment = .center
        return view
    }()
    
    lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [likedButton, titleLabel, searchButton])
        view.axis = .horizontal
        return view
    }()
    
    private let likedButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        return btn
    }()
    
    private let titleLabel = CustomLabel(text: "지역", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    let searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        return view
    }()
    
    private let currentTempLabel = CustomLabel(text: "현재온도", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    private let timeLabel = CustomLabel(text: "시간", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold)
    
    private let maxminTempLabel = CustomLabel(text: "최고 / 최저", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    // devider
    
    lazy var weatherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [descriptionLabel, todayCollectionView, windView, humidityView, sunsetView, sunriseView])
        view.spacing = Util.verticalMargin
        view.axis = .vertical
        return view
    }()
    
    let todayCollectionView = WeatherCollectionView(backgroundColor: .customSkyblue, cell: WeatherCollectionViewCell.self)
    
    private let descriptionLabel = CustomLabel(text: "오늘의 날씨는?", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    lazy var windView = CustomWeatherView(title: "풍속", viewHeight: 160, type: .label, addView: windLabel)
    private let windLabel = CustomLabel(text: "바람", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    lazy var humidityView = CustomWeatherView(title: "습도", viewHeight: 160, type: .label, addView: humidityLabel)
    private let humidityLabel = CustomLabel(text: "습기", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    lazy var sunsetView = CustomWeatherView(title: "일출시간", viewHeight: 80, type: .label, addView: sunsetLabel)
    private let sunsetLabel = CustomLabel(text: "일출", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    lazy var sunriseView = CustomWeatherView(title: "일몰시간", viewHeight: 80, type: .label, addView: sunriseLabel)
    private let sunriseLabel = CustomLabel(text: "일몰", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    // MARK: LifeCycle

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(todayStackView)
        contentView.addSubview(weatherStackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        todayStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
        }
        
        todayCollectionView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        weatherIcon.snp.makeConstraints {
            $0.size.equalTo(100)
        }
        
        weatherStackView.snp.makeConstraints {
            $0.top.equalTo(todayStackView.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(Util.horizontalMargin)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func updateUI(title: String, icon: String, currentTemp: String, time: String, description: String, maxTemp: String, minTemp: String, wind: String, humidity: String, sunset: String, sunrise: String) {
        currentTempLabel.text = "\(currentTemp)℃"
        titleLabel.text = title
        weatherIcon.setIcon(icon: icon)
        timeLabel.text = "\(time) 기준"
        maxminTempLabel.text = "최고:\(maxTemp)℃ / 최저:\(minTemp)℃"
        descriptionLabel.text = description
        windLabel.text = wind
        humidityLabel.text = humidity
        sunsetLabel.text = "\(sunset)에 해가 뜹니다."
        sunriseLabel.text = "\(sunrise)에 해가 집니다."
    }
    
    func selectedUI(selected: Bool) {
        if !selected {
            // 오늘
            sunsetView.isHidden = false
            sunriseView.isHidden = false
        } else {
            // 내일
            sunsetView.isHidden = true
            sunriseView.isHidden = true
        }
    }
}
