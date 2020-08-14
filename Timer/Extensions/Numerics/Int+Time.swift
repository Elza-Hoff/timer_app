//
//  Int+Time.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

extension Int {
    
    func getSeparatedTime() -> (hours: Int, minutes: Int, seconds: Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
}
