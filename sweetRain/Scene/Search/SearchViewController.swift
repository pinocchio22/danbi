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
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    // MARK: Method
    private func setupUI() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
