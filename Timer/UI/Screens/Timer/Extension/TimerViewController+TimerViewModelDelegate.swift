//
//  TimerViewController+TimerViewModelDelegate.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

extension TimerViewController: TimerViewModelDelegate {
    
    func showErrorToast(description: String) {
        
    }
    
    func updatePickerViewWith(hours: Int, minutes: Int, seconds: Int) {
        self.scrollPickerView(row: hours, component: Time.hours.rawValue)
        self.scrollPickerView(row: minutes, component: Time.minutes.rawValue)
        self.scrollPickerView(row: seconds, component: Time.seconds.rawValue)
    }
    
    func timerDidEnd() {
        //TO DO: local notification
        self.setControlPanel(hidden: true)
        self.setTimerViewInteractions(enabled: true)
    }
    
    func shouldUpdateTableView() {
        self.updateTableView()
    }
    
}
