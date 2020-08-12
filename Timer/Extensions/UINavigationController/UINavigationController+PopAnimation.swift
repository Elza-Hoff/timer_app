//
//  UINavigationController+PopAnimation.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, transition: CATransition) {
        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(viewController, animated: false)
    }
    
    func popToRootViewController(transition: CATransition) {
        self.view.layer.add(transition, forKey: kCATransition)
        self.popToRootViewController(animated: false)
    }

    func popViewController(transition: CATransition) {
        self.view.layer.add(transition, forKey: kCATransition)
        self.popViewController(animated: false)
    }

    @discardableResult
    func popViewController(toController classController: AnyClass, animated: Bool) -> Bool {
        var controller:UIViewController? = nil
        for vc in self.viewControllers {
            if vc.classForCoder == classController {
                controller = vc
            }
        }
        if let controller = controller {
            self.popToViewController(controller, animated: animated)
            return true
        }
        return false
    }
    
    func contains(controller classController: AnyClass) -> Bool {
        for vc in self.viewControllers {
            if vc.classForCoder == classController {
                return true
            }
        }
        return false
    }
    
    
}
