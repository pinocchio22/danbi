//
//  Throttler.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/14.
//

import Foundation

class Throttler {
    private let queue: DispatchQueue = .main
        private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
        private var previousRun: Date = .distantPast
        private var maxInterval: Int

        init(maxInterval: Int) {
            self.maxInterval = maxInterval
        }

        func throttle(_ block: @escaping () -> Void) {
            workItem.cancel()

            workItem = DispatchWorkItem() { [weak self] in
                self?.previousRun = Date()
                block()
            }

            let delay = Int(Date().timeIntervalSince(previousRun)) > maxInterval ? 0 : maxInterval
            queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
        }
}
