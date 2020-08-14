//
//  ErrorToastProtocol.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

protocol ErrorToastProtocol {
    
    func showToast(message: String)
    
}

extension ErrorToastProtocol where Self: UIViewController {
    
    func showToast(message: String) {
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + UIWindow.heightOfTopSafeArea + navigationBarHeight, width: self.view.frame.size.width, height: 35))
        toastLabel.backgroundColor = UIColor.yellowBorderColor.withAlphaComponent(0.6)
        toastLabel.clipsToBounds  =  true
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 10
        toastLabel.numberOfLines = 0
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

