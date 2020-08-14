//
//  TimerPickerView.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

protocol TimerPickerViewDelegate: class {
    
    func didMakeSelectionWith(hours: String, minutes: String, seconds: String)
    
}

class TimerPickerView: BaseView {

    //MARK: - Properties
    
    @IBOutlet weak var pvTimer: UIPickerView!
    
    weak var delegate: TimerPickerViewDelegate?
    
    //MARK: - Lifecycle
    
    override func commonInit() {
        super.commonInit()
        self.fromNib()
        self.configurePicker()
    }
    
    func getCurrentPickerValue() -> (hours: String, minutes: String, seconds: String) {
        let hours = Time.hours.timeStringArray[self.pvTimer.selectedRow(inComponent: Time.hours.rawValue)]
        let minutes = Time.minutes.timeStringArray[self.pvTimer.selectedRow(inComponent: Time.minutes.rawValue)]
        let seconds = Time.seconds.timeStringArray[self.pvTimer.selectedRow(inComponent: Time.seconds.rawValue)]
        return (hours, minutes, seconds)
    }
    
    func select(row: Int, component: Int) {
        self.pvTimer.selectRow(row, inComponent: component, animated: true)
    }
    
    func setInteraction(enabled: Bool) {
        self.pvTimer.isUserInteractionEnabled = enabled
    }
    
    private func configurePicker() {
        self.pvTimer.dataSource = self
        self.pvTimer.delegate = self
    }
    
}

//MARK: - UIPickerViewDataSource
extension TimerPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Time.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Time.from(component: component)?.numberOfRows ?? 0
    }
        
}

//MARK: - UIPickerViewDelegate
extension TimerPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Time.from(component: component)?.timeStringArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let timeSelected = self.getCurrentPickerValue()
        self.delegate?.didMakeSelectionWith(hours: timeSelected.hours, minutes: timeSelected.minutes, seconds: timeSelected.seconds)
    }
    
}
