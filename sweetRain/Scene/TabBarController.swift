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
            (WeeklyViewController(), "todayTabBar"),
            (TodayViewController(), "weeklyTabBar")
        ]
        
//        self.tabBar.backgroundColor = .gray
        
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

extension UIImage {
    func scale(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
