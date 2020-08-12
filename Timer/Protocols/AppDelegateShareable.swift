//
//  AppDelegateShareable.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

protocol AppDelegateShareable {
    
    static var shared: AppDelegate? { get }
    
}

//MARK: - AppDelegateShareable
extension AppDelegate: AppDelegateShareable {
    
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
}
