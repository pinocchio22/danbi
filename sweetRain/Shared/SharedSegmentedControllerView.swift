//
//  SharedSegmentedControls.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/05.
//

import UIKit

import SnapKit

class SharedSegmentedControllerView: UIView {
    // MARK: Properties
    let segmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["firstView", "secondView"])
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
    }()
    
    let firstView: UIView = {
      let view = UIView()
      view.backgroundColor = .green
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let secondView: UIView = {
      let view = UIView()
      view.backgroundColor = .yellow
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    private func setupUI() {
        addSubview(segmentedControl)
        addSubview(firstView)
        addSubview(secondView)
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Util.verticalMargin)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
        
        firstView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).inset(Util.verticalMargin)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Util.horizontalMargin)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
