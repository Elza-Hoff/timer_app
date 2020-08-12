//
//  UINavigationController+SwapTransition.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func swapViewControllers(viewControllers controllers: [UIViewController], animated: Bool) {
        var viewControllers = self.viewControllers
        viewControllers.removeLast()
        viewControllers.append(contentsOf: controllers)
        self.setViewControllers(viewControllers, animated: animated)
    }
    
    func swapViewController(viewController controller: UIViewController, animated: Bool) {
        var viewControllers = self.viewControllers
        viewControllers.removeLast()
        viewControllers.append(controller)
        self.setViewControllers(viewControllers, animated: animated)
    }
    
    func swapViewController(viewController: UIViewController, withTransition transition: CATransition, animated: Bool) {
        self.view.layer.add(transition, forKey: kCATransition)
        self.swapViewController(viewController: viewController, animated: animated)
    }
    
    func swapViewController(_ controller: UIViewController, at index: Int, animated: Bool) {
        var viewControllers: [UIViewController] = []
        for idx in 0..<self.viewControllers.count {
            if idx == index {
                viewControllers.append(controller)
                break
            }
            viewControllers.append(self.viewControllers[idx])
        }
        self.setViewControllers(viewControllers, animated: animated)
    }
    
    func swapViewController(_ controller: UIViewController, afterControllerClass classController: AnyClass, animated: Bool) {
        var viewControllers: [UIViewController] = []
        for vc in self.viewControllers {
            if vc.classForCoder == classController {
                viewControllers.append(vc)
                viewControllers.append(controller)
                break
            }
            viewControllers.append(vc)
        }
        self.setViewControllers(viewControllers, animated: animated)
    }
    
    func swapViewControllers(_ controllers: [UIViewController],  afterControllerClass classController: AnyClass, animated: Bool) {
        var viewControllers: [UIViewController] = []
        for vc in self.viewControllers {
            if vc.classForCoder == classController {
                viewControllers.append(vc)
                viewControllers.append(contentsOf: controllers)
                break
            }
            viewControllers.append(vc)
        }
        self.setViewControllers(viewControllers, animated: animated)
    }
    
    func swapViewController(_ controller: UIViewController, fromControllerClass classController: AnyClass, animated: Bool) {
        var viewControllers: [UIViewController] = []
        for vc in self.viewControllers {
            if vc.classForCoder == classController {
                viewControllers.append(controller)
                break
            }
            viewControllers.append(vc)
        }
        self.setViewControllers(viewControllers, animated: animated)
    }
    
}
