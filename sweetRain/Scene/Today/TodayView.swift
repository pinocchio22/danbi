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
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let contentView = UIView()
    
    private let selectDayView = CustomSegmentedControllerView(firstTitle: "오늘", secondTitle: "내일")
    
    lazy var todayStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleStackView, weatherIcon, currentTempLabel, weatherLabel, maxminTempLabel])
        view.axis = .vertical
        view.spacing = Util.verticalMargin
        view.alignment = .center
        return view
    }()
    
    lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [likedButton, title, searchButton])
        view.axis = .horizontal
        return view
    }()
    
    private let likedButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let title = CustomLabel(text: "지역", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    private let searchButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        return view
    }()
    
    private let currentTempLabel = CustomLabel(text: "현재온도", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    private let weatherLabel = CustomLabel(text: "맑음 / 흐림 / 눈", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
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
    
    private let windView = CustomWeatherView(title: "풍속", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold, viewHeight: 100)
    
    private let humidityView = CustomWeatherView(title: "습도", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold, viewHeight: 100)
    
    private let sunsetView = CustomWeatherView(title: "일출시간", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold, viewHeight: 100)
    
    private let sunriseView = CustomWeatherView(title: "일몰시간", textColor: .black, fontSize: Util.smallFont, fontWeight: .bold, viewHeight: 100)
    
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
        addSubview(selectDayView)
        selectDayView.contentView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(todayStackView)
        contentView.addSubview(weatherStackView)
        
        selectDayView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(selectDayView.contentView)
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
}
