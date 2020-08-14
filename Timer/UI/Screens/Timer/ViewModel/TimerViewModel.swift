//
//  TimerViewModel.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

protocol TimerViewModelDelegate: class {
    
    func showToast(error: Error)
    
    func updatePickerViewWith(hours: Int, minutes: Int, seconds: Int)
    
    func timerDidEnd()
    
    func timerWasCancelled()
    
    func shouldUpdateTableView()
}

class TimerViewModel: NSObject {
    
    //MARK: - Properties
    
    weak var delegate: TimerViewModelDelegate?
    
    lazy var timerHelper: TimerHelper = {
        let helper = TimerHelper(secondCallback: { (lastedSeconds) in
            let timeLasted = lastedSeconds.getSeparatedTime()
            self.delegate?.updatePickerViewWith(hours: timeLasted.hours, minutes: timeLasted.minutes, seconds: timeLasted.seconds)
        }, timerDidEnd: {
            self.delegate?.timerDidEnd()
        }) {
            //TODO: delete timer from the tableView
            self.delegate?.timerWasCancelled()
            self.delegate?.shouldUpdateTableView()
        }
        return helper
    }()
    
    var secondsToTheEnd: Int = 0
    
    //MARK: - Lifecycle
    
    func setTimer(with title: String?) {
        guard let title = title else {
            self.delegate?.showToast(error: .noTimerTitle)
            return
        }
        if self.secondsToTheEnd == 0 {
            self.delegate?.showToast(error: .invalidTime)
            return
        }
        self.timerHelper.startTimer(for: self.secondsToTheEnd)
        self.delegate?.shouldUpdateTableView()
    }
    
    func killTimer() {
        self.secondsToTheEnd = 0
        self.timerHelper.cancel()
    }
    
    func pauseTimer() {
        self.timerHelper.pause()
    }
    
    func resumeTimer() {
        self.timerHelper.resume()
    }
    
    func calculateSecondsFrom(hour: String, miutes: String, seconds: String) {
        let hourDigits = (Int(hour.digits) ?? 0) * 3600
        let minutesDigits = (Int(miutes.digits) ?? 0) * 60
        let secondDigits = Int(seconds.digits) ?? 0
        self.secondsToTheEnd = hourDigits + minutesDigits + secondDigits
    }
}
