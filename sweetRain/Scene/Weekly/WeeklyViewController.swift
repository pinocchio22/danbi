//
//  ViewController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/04.
//

import UIKit

import SnapKit

class WeeklyViewController: UIViewController {
    // MARK: Properties

    private let WeeklyCollectionView = WeeklyView()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
    }
    
    // MARK: Method

    private func setupUI() {
        view.addSubview(WeeklyCollectionView)
        
        WeeklyCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
    }
    
    private func configureUI() {
        WeeklyCollectionView.weeklyCollectionView.delegate = self
        WeeklyCollectionView.weeklyCollectionView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension WeeklyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyCollectionViewCell.identifier, for: indexPath) as? WeeklyCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
