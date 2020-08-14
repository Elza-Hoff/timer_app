//
//  TimerHelper.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

class TimerHelper: NSObject {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let second: TimeInterval = 1
    }
    
    //MARK: - Properties
    
    var timer = Timer()
    
    var secondsToTheEnd: Int = 0
    
    var secondCallback: ((Int) -> ())
    
    var timerDidEndCallback: (() -> ())
    
    var isRunning = false
    
    //MARK: - Initialization
    
    init(secondCallback: @escaping ((Int) -> ()), timerDidEnd: @escaping (() ->())) {
        self.secondCallback = secondCallback
        self.timerDidEndCallback = timerDidEnd
    }
    
    //MARK: - Lifecycle
    
    func startTimer(for seconds: Int) {
        self.secondsToTheEnd = seconds
        self.timer = Timer.scheduledTimer(timeInterval: Defaults.second, target: self, selector: #selector(secondDidPass), userInfo: nil, repeats: true)
        self.isRunning = true
    }
    
    func pause() {
        if self.isRunning {
            self.timer.invalidate()
            self.isRunning = false
        }
    }
    
    func resume() {
        if !self.isRunning {
            self.startTimer(for: self.secondsToTheEnd)
        }
    }
    
    private func checkIfTimerDidReachTheEnd() {
        if secondsToTheEnd == 0 {
            self.timerDidEndCallback()
            self.pause()
        }
    }
    
    //MARK: - Handlers
    
    @objc private func secondDidPass() {
        self.secondsToTheEnd -= 1
        self.secondCallback(self.secondsToTheEnd)
        self.checkIfTimerDidReachTheEnd()
    }
    
}
