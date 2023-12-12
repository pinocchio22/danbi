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

    private let weeklyCollectionView = WeeklyView()
    
    private let viewModel = weeklyViewModel()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
        getWeeklyWeather()
        bind()
    }
    
    // MARK: Method

    private func setupUI() {
        view.addSubview(weeklyCollectionView)
        
        weeklyCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
    }
    
    private func configureUI() {
        weeklyCollectionView.weeklyCollectionView.delegate = self
        weeklyCollectionView.weeklyCollectionView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bind() {
        viewModel.dayOfWeekDic.bind {_ in
            self.weeklyCollectionView.weeklyCollectionView.reloadData()
        }
    }
    
    private func getWeeklyWeather() {
        viewModel.getWeeklyWeather()
    }
}

extension WeeklyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dayOfWeekDic.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyCollectionViewCell.identifier, for: indexPath) as? WeeklyCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.getMaxMinTemp()[indexPath.row]
        cell.bind(day: item.date, icon: item.icon ?? "", max: item.maxTemp, min: item.minTemp)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
