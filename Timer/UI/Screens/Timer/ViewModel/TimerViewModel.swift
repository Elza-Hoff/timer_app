//
//  TimerViewModel.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

protocol TimerViewModelDelegate: class {
    
    func showErrorToast(description: String)
    
    func updatePickerViewWith(hours: Int, minutes: Int, seconds: Int)
    
    func timerDidEnd()
    
    func shouldUpdateTableView()
}

class TimerViewModel: NSObject {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let titleIsMissing = "Timer title is missing, please enter it"
        static let invalidTime = "Please set valid time"
    }
    
    //MARK: - Properties
    
    weak var delegate: TimerViewModelDelegate?
    
    lazy var timerHelper: TimerHelper = {
        let helper = TimerHelper(secondCallback: { (lastedSeconds) in
            let timeLasted = lastedSeconds.getSeparatedTime()
            self.delegate?.updatePickerViewWith(hours: timeLasted.hours, minutes: timeLasted.minutes, seconds: timeLasted.seconds)
        }) {
            self.delegate?.timerDidEnd()
        }
        return helper
    }()
    
    var secondsToTheEnd: Int = 0
    
    //MARK: - Lifecycle
    
    func setTimer(with title: String?) {
        guard let title = title else {
            self.delegate?.showErrorToast(description: Defaults.titleIsMissing)
            return
        }
        if self.secondsToTheEnd == 0 {
            self.delegate?.showErrorToast(description: Defaults.invalidTime)
            return
        }
        self.timerHelper.startTimer(for: secondsToTheEnd)
        self.delegate?.shouldUpdateTableView()
    }
    
    func calculateSecondsFrom(hour: String, miutes: String, seconds: String) {
        let hourDigits = (Int(hour.digits) ?? 0) * 60
        let minutesDigits = (Int(miutes.digits) ?? 0) * 60
        let secondDigits = Int(seconds.digits) ?? 0
        self.secondsToTheEnd = hourDigits + minutesDigits + secondDigits
    }
}
