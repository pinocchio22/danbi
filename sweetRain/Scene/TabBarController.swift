//
//  TabBarController.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [(root: UIViewController, icon: String)] = [
            (WeeklyViewController(), "car"),
            (TodayViewController(), "book"),
            (SettingViewController(), "map")
        ]
        
        self.tabBar.backgroundColor = .gray
        self.tabBar.tintColor = .black
        
        self.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }, animated: false)
        
        self.selectedIndex = 1
    }
}
