//
//  UIWindow+SafeAreaSizes.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 14.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension UIWindow {
    
    static var heightOfTopSafeArea: CGFloat {
        var topPadding: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first else {
                    return topPadding
            }
            topPadding = keyWindow.safeAreaInsets.top
        } else {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        return topPadding
    }
    
}
