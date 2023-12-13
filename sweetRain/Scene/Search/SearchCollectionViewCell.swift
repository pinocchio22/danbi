//
//  SearchCollectionViewCell.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var filteredWeather: [SearchWeather]?

    private let likedButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = .systemYellow
        return btn
    }()
    
    private let nameLabel = CustomLabel(text: "지역명", textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
    
    private let searchResultCollectionView = WeatherCollectionView(backgroundColor: .customSkyblue, cell: WeatherCollectionViewCell.self)
    
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
        addSubview(likedButton)
        addSubview(nameLabel)
        addSubview(searchResultCollectionView)
        
        likedButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(nameLabel)
            $0.size.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(likedButton.snp.trailing).inset(-Util.horizontalMargin)
        }
        
        searchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(likedButton.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    func bind(filteredWeather: [SearchWeather]) {
        if filteredWeather.isEmpty {
            self.likedButton.isHidden = true
            self.searchResultCollectionView.isHidden = true
            self.nameLabel.isHidden = true
        } else {
            self.likedButton.isHidden = false
            self.searchResultCollectionView.isHidden = false
            self.nameLabel.isHidden = false
            self.nameLabel.text = filteredWeather.first?.cityname
            self.filteredWeather = filteredWeather
            self.searchResultCollectionView.reloadData()
        }
    }
}

extension SearchCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        guard let item = filteredWeather?[indexPath.row] else { return UICollectionViewCell() }
        cell.bind(time: item.timeStamp, icon: item.icon ?? "", temp: String(item.temp))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
