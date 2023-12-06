//
//  SharedSegmentedControls.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class CustomSegmentedControllerView: UIView {
    // MARK: Properties

    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: self.items)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.cornerRadius = Util.largeCorner
        return control
    }()

    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var items: [String]?

    private func setupUI() {
        addSubview(segmentedControl)
        addSubview(contentView)

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.centerX.equalTo(self)
            $0.width.equalTo(Util.mainWidth * 0.7)
            $0.height.equalTo(40)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).inset(-Util.verticalMargin)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
    }

    init(firstTitle: String, secondTitle: String) {
        super.init(frame: .zero)
        items = [firstTitle, secondTitle]
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
