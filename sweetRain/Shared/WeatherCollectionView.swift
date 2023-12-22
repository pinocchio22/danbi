//
//  WeatherCollectionView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

class WeatherCollectionView: UICollectionView {
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    init(backgroundColor: UIColor, cell: UICollectionViewCell.Type) {
        super.init(frame: .zero, collectionViewLayout: self.flowLayout)
        self.isScrollEnabled = true
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.showsHorizontalScrollIndicator = false
        self.layer.cornerRadius = Util.largeCorner
        self.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
