//
//  UINavigationController+RootViewController.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UINavigationController {

    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
}

