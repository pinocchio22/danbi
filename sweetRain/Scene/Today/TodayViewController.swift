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

    private let selectDayView = CustomSegmentedControllerView(firstTitle: "오늘", secondTitle: "내일")
    private let todayView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
        bind()
        setSegmented()
        setActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentWeather()
        getHourlyWeather(type: .today)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.addSubview(selectDayView)

        selectDayView.contentView.addSubview(todayView)
        
        selectDayView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        todayView.snp.makeConstraints {
            $0.edges.equalTo(selectDayView.contentView)
        }
    }
    
    private func configureUI() {
        todayView.todayCollectionView.delegate = self
        todayView.todayCollectionView.dataSource = self
    }
    
    private func getCurrentWeather() {
        viewModel.getCurrentWeather()
    }
    
    private func getHourlyWeather(type: WeatherViewType) {
        viewModel.getHourlyWeather(type: type)
    }
    
    private func bind() {
        self.viewModel.currentWeather.bind { weather in
            if let weather = weather {
                self.todayView.updateUI(title: weather.location , icon: weather.icon ?? "", currentTemp: String(weather.currentTemp ), time: weather.timeStamp, description: weather.description, maxTemp: String(weather.maxTemp ), minTemp: String(weather.minTemp ), wind: String(weather.windSpeed), humidity: String(weather.humidity), sunset: (weather.sunSet ?? 0).unixToTime(), sunrise: (weather.sunRise ?? 0).unixToTime(), liked: self.viewModel.checkLikedWeather(weather: weather))

            }
        }
        
        self.viewModel.hourlyWeather.bind {_ in
            self.todayView.todayCollectionView.reloadData()
        }
        
        self.viewModel.selectedIndex.bind { selected in
            self.todayView.selectedUI(selected: selected)
            if !selected {
                // 오늘 데이터 불러오기
                self.getHourlyWeather(type: .today)
            } else {
                // 내일 데이터 불러오기
                self.getHourlyWeather(type: .tomorrow)
            }
        }
    }
    
    private func setSegmented() {
        selectDayView.segmentedControl.addAction(UIAction(handler: { _ in
            Throttler(maxInterval: 400).throttle {
                self.viewModel.selectedIndex.value = self.selectDayView.segmentedControl.selectedSegmentIndex != 0
            }
        }), for: .valueChanged)
    }
    
    private func setActions() {
        todayView.searchButton.addAction(UIAction(handler: { _ in
            let vc = SearchViewController()
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        todayView.likedButton.addAction(UIAction(handler: { _ in
            self.todayView.likedButtonTapped(selected: self.viewModel.likedWeather(weather: self.viewModel.hourlyWeather.value))
        }), for: .touchUpInside)
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hourlyWeatherCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        if let item = viewModel.hourlyWeather.value[indexPath.row] {
            cell.bind(time: item.timeStamp , icon: item.icon ?? "" , temp: String(item.currentTemp))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
