//
//  SearchViewController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/06.
//

import UIKit

import SnapKit

class SearchViewController: UIViewController {
    // MARK: Properties

    private let searchView = SearchView()
    
    private let viewModel = SearchViewModel()
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        configureUI()
        setSearchBar()
        setSegmented()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    // MARK: Method

    private func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        searchView.delegate = self
    }
    
    private func bind() {
        viewModel.selectedIndex.bind { selected in
            self.searchView.selectedUI(selected: selected, weather: self.viewModel.getLikedWeather())
        }
        
        viewModel.filteredWeather.bind { weather in
            if !weather.isEmpty {
                self.searchView.checkLiked(liked: self.viewModel.checkLikedWeather(weather: weather.first?.first?.location ?? ""))
            }
            self.searchView.updateUI(filteredWeather: weather)
        }
    }
    
    private func setSegmented() {
        searchView.selectSearchView.segmentedControl.addAction(UIAction(handler: { _ in
            self.viewModel.selectedIndex.value = self.searchView.selectSearchView.segmentedControl.selectedSegmentIndex != 0
        }), for: .valueChanged)
    }
    
    private func setSearchBar() {
        searchView.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()

        guard let text = searchView.searchBar.text else { return }
        viewModel.searchWeather(cityName: text)
        
        searchView.searchCollectionView.reloadData()
    }
        
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchWeather(cityName: "")
    }
        
    func dismissKeyboard() {
        searchView.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: SearchViewDelegate {
    func didTapLikedButton(in cell: SearchCollectionViewCell, at indexPath: IndexPath) {
        if let weather = cell.filteredWeather {
            cell.likedButton.isSelected = viewModel.likedWeather(weather: weather)
        }
    }
}
