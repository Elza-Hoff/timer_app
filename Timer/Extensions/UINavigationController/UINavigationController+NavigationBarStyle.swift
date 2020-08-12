//
//  UINavigationController+NavigationBarStyle.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    //MARK: - Constants
    
    enum NavigationBarStyle {
        case white
        case lightGray
    }
    
    func applyBackgroundNavigation(with style: NavigationBarStyle) {
        switch style {
        case .lightGray:
            self.navigationBar.barTintColor = .lightGray
            break
        case .white:
            self.navigationBar.barTintColor = .white
            break
        }
    }
    
}
