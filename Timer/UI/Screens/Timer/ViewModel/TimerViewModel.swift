//
//  TimerViewModel.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation
import CoreData

protocol TimerViewModelDelegate: class {
    
    func showToast(error: Error)
    
    func updatePickerViewWith(hours: Int, minutes: Int, seconds: Int)
    
    func timerDidEnd()
    
    func timerWasCancelled()
    
    func shouldUpdateTableView()
}

class TimerViewModel: NSObject {
    
    //MARK: - Defaults
    
    private enum Templates {
        static let timeTemplate = "{h}h {m}m {s}s"
        static let second = "{s}"
        static let minute = "{m}"
        static let hour = "{h}"
    }
    
    //MARK: - Properties
    
    weak var delegate: TimerViewModelDelegate?
    
    lazy var timerHelper: TimerHelper = {
        let helper = TimerHelper(secondCallback: { (lastedSeconds) in
            let timeLasted = lastedSeconds.getSeparatedTime()
            self.delegate?.updatePickerViewWith(hours: timeLasted.hours, minutes: timeLasted.minutes, seconds: timeLasted.seconds)
        }, timerDidEnd: {
            self.delegate?.timerDidEnd()
        }) {
            //TODO: delete timer record from the tableView
            self.delegate?.timerWasCancelled()
            self.delegate?.shouldUpdateTableView()
        }
        return helper
    }()
    
    private var secondsToTheEnd: Int = 0
    
    private var timers = [UserTimer]()
    
    //MARK: - Lifecycle
    
    func getCellTitle(for indexPath: IndexPath) -> String? {
        let timerRecord = self.timers[indexPath.row]
        let timeData = Int(timerRecord.time).getSeparatedTime()
        let time = Templates.timeTemplate.replacingOccurrences(of: Templates.hour, with: timeData.hours.description).replacingOccurrences(of: Templates.minute, with: timeData.minutes.description).replacingOccurrences(of: Templates.second, with: timeData.seconds.description)
        return time + Separators.space + (timerRecord.timerDescription ?? "")
    }
    
    func getLastTimerDescription() -> String? {
        return self.timers.first?.timerDescription
    }
    
    func getCellsCount() -> Int {
        return self.timers.count
    }
    
    func setTimer(with title: String?) {
        if title == nil || title?.isEmpty ?? true {
            self.delegate?.showToast(error: .noTimerTitle)
            return
        }
        if self.secondsToTheEnd == 0 {
            self.delegate?.showToast(error: .invalidTime)
            return
        }
        self.timerHelper.startTimer(for: self.secondsToTheEnd)
        self.createTimerRecord(title: title!, time: self.secondsToTheEnd)
    }
    
    func killTimer() {
        self.secondsToTheEnd = 0
        self.timerHelper.cancel()
        self.deleteLastTimerRecord()
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
    
    //MARK: - CoreData
    
    func fetchAllTimers() {
        self.timers = CoreDataManager.getItems(name: Models.userTimer.rawValue).sorted(by: {$0.date! > $1.date!})
        self.delegate?.shouldUpdateTableView()
    }
    
    func createTimerRecord(title: String, time: Int) {
        CoreDataManager.create(name: Models.userTimer.rawValue)
        { (item: UserTimer) in
            item.date = Date()
            item.timerDescription = title
            item.id = Int32(self.timers.count)
            item.time = Int32(time)
            self.fetchAllTimers()
        }
    }
    
    func deleteLastTimerRecord() {
        CoreDataManager.delete(model: self.timers.first)
        self.fetchAllTimers()
    }
}
