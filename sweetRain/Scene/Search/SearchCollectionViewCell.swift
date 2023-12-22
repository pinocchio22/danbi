//
//  SearchCollectionViewCell.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

protocol SearchCollectionViewCellDelegate: AnyObject {
    func likedButtonTapped(in cell: SearchCollectionViewCell, at indexPath: IndexPath)
    
    func updateLikedButton(liked: Bool)
}

class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: Properties

    var filteredWeather: [CurrentWeather]?
    
    weak var delegate: SearchCollectionViewCellDelegate?
    var indexPath: IndexPath?

    let likedButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.setImage(UIImage(systemName: "star.fill"), for: .selected)
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
        setActions()
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
            $0.top.leading.equalToSuperview().inset(Util.verticalMargin)
            $0.size.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Util.verticalMargin + 2)
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
    
    private func setActions() {
        likedButton.addAction(UIAction(handler: { _ in
            if let indexPath = self.indexPath {
                self.delegate?.likedButtonTapped(in: self, at: indexPath)
            }
        }), for: .touchUpInside)
    }
    
    func bind(filteredWeather: [CurrentWeather], liked: Bool) {
        if filteredWeather.isEmpty {
            // 즐겨찾기
            likedButton.isHidden = true
            searchResultCollectionView.isHidden = true
            nameLabel.isHidden = true
        } else {
            // 검색
            likedButton.isHidden = false
            likedButton.isSelected = liked
            searchResultCollectionView.isHidden = false
            nameLabel.isHidden = false
            nameLabel.text = filteredWeather.first?.location
            self.filteredWeather = filteredWeather
            searchResultCollectionView.reloadData()
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
        cell.bind(time: item.timeStamp, icon: item.icon ?? "", temp: String(item.currentTemp))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
