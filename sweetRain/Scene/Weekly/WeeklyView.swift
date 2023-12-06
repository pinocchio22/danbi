//
//  WeeklyView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

class WeeklyView: UIView {
    // MARK: Properties
    
    private let pageTitleLabel = CustomLabel(text: "주간날씨", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.register(WeeklyCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyCollectionViewCell.identifier)
        return view
    }()
    
    // MARK: LifeCycle

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: Method

    private func setupUI() {
        addSubview(pageTitleLabel)
        addSubview(collectionView)
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
