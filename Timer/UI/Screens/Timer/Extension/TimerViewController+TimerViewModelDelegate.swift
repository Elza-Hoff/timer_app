//
//  TimerViewController+TimerViewModelDelegate.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension TimerViewController: TimerViewModelDelegate {
    
    func showToast(error: Error) {
        if error == .noTimerTitle || error == .invalidTime {
            self.prepareTimeUIFor(start: false)
        }
        self.showToast(message: error.description)
    }
    
    func updatePickerViewWith(hours: Int, minutes: Int, seconds: Int) {
        self.scrollPickerView(row: hours, component: Time.hours.rawValue)
        self.scrollPickerView(row: minutes, component: Time.minutes.rawValue)
        self.scrollPickerView(row: seconds, component: Time.seconds.rawValue)
    }
    
    func timerDidEnd() {
        //TO DO: local notification
        self.prepareTimeUIFor(start: false)
    }
    
    func timerWasCancelled() {
        self.prepareTimeUIFor(start: false)
        self.resetPickerViewToStartState()
    }
    
    func shouldUpdateTableView() {
        self.updateTableView()
    }
    
}
