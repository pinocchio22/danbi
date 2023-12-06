//
//  SearchView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

class SearchView: UIView {
    // MARK: Properties
    private let selectSearchView = CustomSegmentedControllerView(firstTitle: "검색", secondTitle: "즐겨찾기")
    
    private let searchTitleLabel = CustomLabel(text: "검색", textColor: .black, fontSize: Util.largeFont, fontWeight: .bold)
    
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
    
    //divider
    
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
        selectSearchView.contentView.addSubview(searchCollectionView)
        
        selectSearchView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
        
        searchTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTitleLabel.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 130)
    }
}
