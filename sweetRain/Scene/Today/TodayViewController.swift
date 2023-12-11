//
//  ViewController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/04.
//

import UIKit

import SnapKit

class TodayViewController: UIViewController {
    // MARK: Properties

    private let viewModel = TodayViewModel()
    
    private let todayView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
        bind()
        getCurrentWeather()
        getHourlyWeather()
    }
    
    private func setupUI() {
        view.addSubview(todayView)
        
        todayView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        todayView.todayCollectionView.delegate = self
        todayView.todayCollectionView.dataSource = self
        navigationController?.navigationBar.isHidden = true
    }
    
    private func getCurrentWeather() {
        viewModel.getCurrentWeather()
    }
    
    private func getHourlyWeather() {
        viewModel.getHourlyWeather(type: .today)
    }
    
    private func bind() {
        self.viewModel.currentWeather.bind { weather in
                self.todayView.updateUI(title: weather?.location ?? "", icon: weather?.icon ?? "", currentTemp: String(weather?.currentTemp ?? 0.0), time: weather?.timeStamp ?? "", description: weather?.description ?? "", maxTemp: String(weather?.maxTemp ?? 0.0), minTemp: String(weather?.minTemp ?? 0.0))
        }
        
        self.viewModel.hourlyWeather.bind { weather in
            self.todayView.todayCollectionView.reloadData()
        }
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hourlyWeather.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        if let item = viewModel.hourlyWeather.value[indexPath.row] {
            cell.bind(time: item.timeStamp , icon: item.icon , temp: String(item.currentTemp))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
