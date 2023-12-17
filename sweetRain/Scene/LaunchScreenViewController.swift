//
//  LaunchScreenViewController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/18.
//

import UIKit

import SDWebImage
import SnapKit

class LaunchScreenViewController: UIViewController {
    // MARK: Properties
    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.alpha = 0.8
        return view
    }()
    
    private let launchLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "launchScreen")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
    
    // MARK: Method
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(launchLogo)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        launchLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Util.horizontalMargin)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        
//        backgroundView.sd_setImage(with: URL(string: "https://i.pinimg.com/originals/84/04/6d/84046da36518327ffe0ee437fe7f1af9.gif"))
        backgroundView.sd_setImage(with: URL(string: "https://i.pinimg.com/originals/1c/c1/a4/1cc1a4bc1873432f3864e649e65b81aa.gif"))
    }
}
