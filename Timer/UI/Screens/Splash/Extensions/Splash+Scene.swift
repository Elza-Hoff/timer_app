//
//  Splash+Scene.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

extension SplashViewController: SceneProtocol {
    
    // MARK: - SceneProtocol
    
    typealias Scene = SplashScene

    // MARK: - Constants
    
    internal enum SplashScene: SceneConfigurable {
        
        case main
        
        var config: SceneConfig? {
            switch self {
            case .main:
                return SceneConfig(controller: TimerViewController.storyboardInstance()!,
                                   initialType: .swap,
                                   isAnimated: false)
            }
        }

    }

}
