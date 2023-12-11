//
//  UIImageView+.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/11.
//

import UIKit

extension UIImageView {
    func setIcon(icon: String) {
        let service = NetworkService()
            service.getIcon(iconCode: icon) { icon in
                DispatchQueue.main.async { [weak self] in
                    if let icon = icon {
                        self?.image = UIImage(data: icon)
                    }
            }
        }
    }
}
