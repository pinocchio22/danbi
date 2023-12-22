//
//  CustomWeatherView.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class CustomWeatherView: UIView {
    // MARK: Properties

    var titleLabel: CustomLabel?
    var height: CGFloat = 0
    var subView: Any?

    // MARK: LifeCycle

    init(title: String, viewHeight: CGFloat) {
        super.init(frame: .zero)
        self.titleLabel = CustomLabel(text: title, textColor: .black, fontSize: Util.mediumFont, fontWeight: .bold)
        self.height = viewHeight
        self.backgroundColor = .customSkyblue
        self.layer.cornerRadius = Util.largeCorner
        self.setupUI()
    }

    convenience init(title: String, viewHeight: CGFloat, type: CustomWeatherViewType, addView: Any) {
        self.init(title: title, viewHeight: viewHeight)
        self.subView = addView

        switch type {
        case .label:
            guard let subView = subView as? UILabel, let titleLabel = titleLabel else { return }
            self.setSubView(subView, titleLabel: titleLabel)

        case .imageView:
            guard let subView = subView as? UIImageView, let titleLabel = titleLabel else { return }
            self.setSubView(subView, titleLabel: titleLabel)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Method

    private func setupUI() {
        guard let titleLabel = titleLabel else { return }

        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(self.height)
        }
    }

    func setSubView<T: UIView>(_ subView: T, titleLabel: UILabel) {
        addSubview(subView)

        subView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Util.verticalMargin)
        }
    }
}
