//
//  ViewController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/04.
//

import UIKit

import SnapKit

class TodayViewController: UIViewController {
    //MARK: Properties
    private let todayView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        setupUI()
    }
    
    private func setupUI() {
        todayView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        
    }
}

