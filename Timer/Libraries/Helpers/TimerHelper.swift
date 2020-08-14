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
    
    private var timer = Timer()
    
    private var secondsToTheEnd: Int = 0
    
    private var isRunning = false
    
    private var isCanceled = false
    
    var secondCallback: ((Int) -> ())
    
    var timerDidEndCallback: (() -> ())
    
    var timerWasCanceledCallback: (() ->())
        
    //MARK: - Initialization
    
    init(secondCallback: @escaping ((Int) -> ()), timerDidEnd: @escaping (() ->()), canceled: @escaping(() ->())) {
        self.secondCallback = secondCallback
        self.timerDidEndCallback = timerDidEnd
        self.timerWasCanceledCallback = canceled
    }
    
    //MARK: - Lifecycle
    
    func startTimer(for seconds: Int) {
        self.secondsToTheEnd = seconds
        self.timer = Timer.scheduledTimer(timeInterval: Defaults.second, target: self, selector: #selector(secondDidPass), userInfo: nil, repeats: true)
        self.isRunning = true
        self.isCanceled = false
    }
    
    func pause() {
        if self.isRunning {
            self.timer.invalidate()
            self.isRunning = false
        } else if self.isCanceled {
            self.timer.invalidate()
            self.isCanceled = false
        }
    }
    
    func resume() {
        if !self.isRunning {
            self.startTimer(for: self.secondsToTheEnd)
        }
    }
    
    func cancel() {
        self.isCanceled = true
        self.secondsToTheEnd = 0
        self.checkIfTimerDidReachTheEnd()
    }
    
    private func checkIfTimerDidReachTheEnd() {
        if self.secondsToTheEnd == 0 {
            if self.isCanceled {
                self.timerWasCanceledCallback()
            } else {
                self.timerDidEndCallback()
            }
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
