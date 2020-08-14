//
//  TimerViewController+TimerPickerViewDelegate.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension TimerViewController: TimerPickerViewDelegate {
    
    func didMakeSelectionWith(hours: String, minutes: String, seconds: String) {
        self.viewModel.calculateSecondsFrom(hour: hours, miutes: minutes, seconds: seconds)
    }
    
    
}
