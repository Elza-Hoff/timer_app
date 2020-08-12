//
//  Int+RGB.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension Int {
    
    var rgb: CGFloat {
        return CGFloat(self/255)
    }
    
    var cgfloat: CGFloat {
        return CGFloat(self)
    }
    
}
