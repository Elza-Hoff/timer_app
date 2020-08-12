//
//  UIViewController+NavigationBar.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: - Defaults
    
    enum Sides {
        case left
        case right
    }
    
    //MARK: - Showing
    
    func showNavBar(animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideNavBar(animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showBackButton() {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = false
    }

    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
    }
    
    //MARK: - Title

    func add(title: String) {
        self.navigationItem.title = title
    }
    
    //MARK: - Colors
    
    func setUpTintForNavBarButton(tint: UIColor, side: Sides) {
        (side == .left ? self.navigationItem.leftBarButtonItem : self.navigationItem.rightBarButtonItem)?.customView?.tintColor = tint
        (side == .left ? self.navigationItem.leftBarButtonItem : self.navigationItem.rightBarButtonItem)?.tintColor = tint
        self.navigationController?.navigationBar.tintColor = tint
    }
    
    func setUpNavigationBar(color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
    }
}
