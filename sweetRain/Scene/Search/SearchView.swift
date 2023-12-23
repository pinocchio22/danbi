//
//  SearchView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

protocol SearchViewDelegate: AnyObject {
    func didTapLikedButton(in cell: SearchCollectionViewCell, at indexPath: IndexPath)
}

class SearchView: UIView {
    // MARK: Properties

    var filteredWeather: [[CurrentWeather]]?
    weak var delegate: SearchViewDelegate?
    var liked: Bool?
    
    let selectSearchView = CustomSegmentedControllerView(firstTitle: "검색", secondTitle: "즐겨찾기")
    
    let searchTitleLabel = CustomLabel(text: "검색", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "지역명"
        bar.showsSearchResultsButton = true
        return bar
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var searchCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return view
    }()
    
    // MARK: LifeCycle

    init() {
        super.init(frame: .zero)
        setupUI()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(selectSearchView)
        selectSearchView.contentView.addSubview(searchTitleLabel)
        selectSearchView.contentView.addSubview(searchBar)
        selectSearchView.contentView.addSubview(searchCollectionView)
        
        selectSearchView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
        
        searchTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(searchTitleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
    func updateUI(filteredWeather: [[CurrentWeather]]) {
        self.filteredWeather = filteredWeather
        searchCollectionView.reloadData()
    }
    
    func checkLiked(liked: Bool) {
        self.liked = liked
    }
    
    func selectedUI(selected: Bool, weather: [[CurrentWeather]]) {
        searchBar.isHidden = selected
        filteredWeather = []
        if !selected {
            // 검색
            searchTitleLabel.text = "검색"
        } else {
            // 즐겨찾기
            searchTitleLabel.text = "즐겨찾기"
            liked = true
            filteredWeather = weather
        }
        searchCollectionView.reloadData()
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        guard let item = filteredWeather?[indexPath.row] else { return UICollectionViewCell() }
        cell.bind(filteredWeather: item, liked: liked ?? false)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 150)
    }
}

extension SearchView: SearchCollectionViewCellDelegate {
    func updateLikedButton(liked: Bool) {
        self.liked = liked
    }
    
    func likedButtonTapped(in cell: SearchCollectionViewCell, at indexPath: IndexPath) {
        delegate?.didTapLikedButton(in: cell, at: indexPath)
    }
}
