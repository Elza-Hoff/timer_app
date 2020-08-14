//
//  Constants.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

// MARK: - Storyboard

enum Storyboard {
    static let main                 = "Main"
    static let splash               = "Splash"
    static let timer                = "Timer"
}

enum Time: Int, CaseIterable {
    case hours = 0
    case minutes
    case seconds
    
    var timeStringArray: [String] {
        switch self {
        case .seconds:
            return 59.arrayFromZeroToSelf.map({$0.description + Separators.space + TimeDescription.secondsShort})
        case .minutes:
            return 59.arrayFromZeroToSelf.map({$0.description + Separators.space + TimeDescription.minutesShort})
        case .hours:
            return 23.arrayFromZeroToSelf.map { (hour) -> String in
                if hour > 1 && hour != 0 {
                    return hour.description + Separators.space + TimeDescription.hours
                } else {
                    return hour.description + Separators.space + TimeDescription.hour
                }
            }
        }
    }
    
    var numberOfRows: Int {
        return self.timeStringArray.count
    }
    
    static func from(component: Int) -> Time? {
        switch component {
        case Time.seconds.rawValue: return .seconds
        case Time.minutes.rawValue: return .minutes
        case Time.hours.rawValue: return .hours
        default: return nil
        }
    }
    
}

enum TimeDescription {
    static let hour = "hour"
    static let hours = "hours"
    static let minutesShort = "min"
    static let secondsShort = "sec"
}

enum Separators {
    static let space = " "
}

//MARK: - Errors

enum Error: Swift.Error {
    case invalidTime
    case noTimerTitle
    
    var description: String {
        switch self {
        case .invalidTime: return ErrorDescription.invalidTime.rawValue
        case .noTimerTitle: return ErrorDescription.noTimerTitle.rawValue
        }
    }
}

enum ErrorDescription: String {
    case invalidTime = "Please set valid time"
    case noTimerTitle = "Timer title is missing, please enter it"
}

//MARK: - CoreData

enum Models: String {
    case userTimer = "UserTimer"
}
