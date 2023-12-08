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
        
        getCurrentWeather()
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
        viewModel.getCurrentWeather {
            self.viewModel.currentWeather?.bind { weather in
                DispatchQueue.main.async {
                    self.todayView.updateUI(title: weather.location, Image: weather.icon ?? Data(), currentTemp: String(weather.currentTemp), time: weather.timeStamp, description: weather.description, maxTemp: String(weather.maxTemp), minTemp: String(weather.minTemp))
                }
            }
        }
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
