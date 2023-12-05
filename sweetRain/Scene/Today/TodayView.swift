//
//  TodayView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

class TodayView: UIView {
    // MARK: Properties
    private let selectDayView = CustomSegmentedControllerView(firstTitle: "오늘", secondTitle: "내일")
    
    private let todayStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    private let titleStackView: UIStackView = {
        let view = UIStackView()
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
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let currentTempLabel = CustomLabel(text: "현재온도", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    private let weatherLabel = CustomLabel(text: "맑음 / 흐림 / 눈", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    private let maxminTempLabel = CustomLabel(text: "최고 / 최저", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
    // devider
    
    private let descriptionLabel = CustomLabel(text: "오늘의 날씨는?", textColor: .black, fontSize: Util.mediumFont, fontWeight: .regular)
    
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
        
        selectDayView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
