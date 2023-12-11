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
//    private let tomorrowView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
        bind()
        getCurrentWeather()
        getHourlyWeather(type: .today)
        setSegmented()
    }
    
    private func setupUI() {
        view.addSubview(selectDayView)

        selectDayView.contentView.addSubview(todayView)
//        selectDayView.contentView.addSubview(tomorrowView)
        
        selectDayView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        todayView.snp.makeConstraints {
            $0.edges.equalTo(selectDayView.contentView)
        }
        
//        tomorrowView.snp.makeConstraints {
//            $0.edges.equalTo(selectDayView.contentView)
//        }
    }
    
    private func configureUI() {
        todayView.todayCollectionView.delegate = self
        todayView.todayCollectionView.dataSource = self
        navigationController?.navigationBar.isHidden = true
    }
    
    private func getCurrentWeather() {
        viewModel.getCurrentWeather()
    }
    
    private func getHourlyWeather(type: WeatherViewType) {
        viewModel.getHourlyWeather(type: type)
    }
    
    private func bind() {
        self.viewModel.currentWeather.bind { weather in
                self.todayView.updateUI(title: weather?.location ?? "", icon: weather?.icon ?? "", currentTemp: String(weather?.currentTemp ?? 0.0), time: weather?.timeStamp ?? "", description: weather?.description ?? "", maxTemp: String(weather?.maxTemp ?? 0.0), minTemp: String(weather?.minTemp ?? 0.0))
        }
        
        self.viewModel.hourlyWeather.bind {_ in
            self.todayView.todayCollectionView.reloadData()
        }
        
        self.viewModel.selectedIndex.bind { selected in
//            self.todayView.isHidden = selected
//            self.tomorrowView.isHidden = !selected
            if selected {
                // 내일 데이터 불러오기
                self.getHourlyWeather(type: .tomorrow)
            } else {
                self.getHourlyWeather(type: .today)
                // 오늘 데이터 불러오기
            }
        }
    }
    
    private func setSegmented() {
        selectDayView.segmentedControl.addAction(UIAction(handler: { _ in
            self.viewModel.selectedIndex.value = self.selectDayView.segmentedControl.selectedSegmentIndex != 0
        }), for: .valueChanged)
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hourlyWeather.value.count
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
