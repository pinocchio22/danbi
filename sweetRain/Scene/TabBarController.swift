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
        
        self.delegate = self
        
        let tabs: [(root: UIViewController, icon: String)] = [
            (WeeklyViewController(), "todayTabBar"),
            (TodayViewController(), "weeklyTabBar")
        ]
        
        self.tabBar.backgroundColor = .customDarkblue
        
        self.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let iconSize = CGSize(width: 40, height: 40)
            let originalImage = UIImage(named: icon)?.scale(to: iconSize)?.withRenderingMode(.alwaysOriginal)
            let selectedImage = UIImage(named: "\(icon).fill")?.scale(to: iconSize)?.withRenderingMode(.alwaysOriginal)
            let tabBarItem = UITabBarItem(title: nil, image: originalImage, selectedImage: selectedImage)
            navigationController.tabBarItem = tabBarItem
            tabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
            return navigationController
        }, animated: false)
        
        self.selectedIndex = 1
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navigationController = viewController as? UINavigationController {
                DispatchQueue.main.async {
                    navigationController.popToRootViewController(animated: false)
                }
            }
        return true
    }
}
