//
//  Int+Array.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension Int {
    
    var arrayFromZeroToSelf: [Int] {
        var result = [Int]()
        for item in 0...self {
            result.append(item)
        }
        return result
    }
    
}
