//
//  SceneProtocol.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

/* SceneConfig Model */

public struct SceneConfig {
    var controller  : UIViewController? = nil
    var initialType : SceneInitialType = .push
    var transition  : CATransition? = nil
    var isAnimated  : Bool = true
}

/* SceneConfigurable Declaration */

protocol SceneConfigurable {
    var config: SceneConfig? { get }
}

/* SceneInitialType Type */

public enum SceneInitialType {
    case push
    case pop
    case modal
    case swap
    case popToRoot
}

/* SceneProtocol Declaration */

protocol SceneProtocol: UIViewController {
    associatedtype Scene: SceneConfigurable
}

/* SceneProtocol Implementation */

extension SceneProtocol {
    
    func loadScene(_ scene: SceneConfigurable) {
        guard let config = scene.config else {
            print("[WARNING]: Scene hasn't been configured before. Check Scene Provider.")
            return
        }
        switch config.initialType {
        case .popToRoot:
            self.popSceenToRoot(isAnimated: config.isAnimated, transition: config.transition)
            break
        case .pop:
            self.popSceneController(isAnimated: config.isAnimated, transition: config.transition)
            break
        case .modal:
            self.presentSceneController(config.controller, isAnimated: config.isAnimated, transition: config.transition)
            break
        case .swap:
            self.changeSceneController(config.controller, isAnimated: config.isAnimated, transition: config.transition)
            break
        case .push:
            self.pushSceneController(config.controller, isAnimated: config.isAnimated, transition: config.transition)
            break
        }
    }
    
    private func pushSceneController(_ controller: UIViewController?,
                                     isAnimated: Bool,
                                     transition: CATransition?) {
        guard let controller = controller else {
            print("[WARNING]: Scene hasn't been configured before. Check Scene Controller.")
            return
        }
        self.navigationController?.pushViewController(controller, animated: isAnimated)
    }
    
    private func changeSceneController(_ controller: UIViewController?,
                                       isAnimated: Bool,
                                       transition: CATransition?) {
        guard let controller = controller else {
            print("[WARNING]: Scene hasn't been configured before. Check Scene Controller.")
            return
        }
        if let transition = transition {
            self.navigationController?.swapViewController(viewController: controller, withTransition: transition, animated: false)
        } else {
            self.navigationController?.swapViewController(viewController: controller, animated: isAnimated)
        }
    }
    
    private func popSceneController(isAnimated: Bool,
                                    transition: CATransition?) {
        if let transition = transition {
            self.navigationController?.popViewController(transition: transition)
        } else {
            self.navigationController?.popViewController(animated: isAnimated)
        }
    }
    
    private func popSceenToRoot(isAnimated: Bool,
                                transition: CATransition?) {
        if let transition = transition {
            self.navigationController?.popToRootViewController(transition: transition)
        } else {
            self.navigationController?.popToRootViewController(animated: isAnimated)
        }
    }
    
    private func presentSceneController(_ controller: UIViewController?,
                                        isAnimated: Bool,
                                        transition: CATransition?) {
        guard let controller = controller else {
            print("[WARNING]: Scene hasn't been configured before. Check Scene Controller.")
            return
        }
        self.present(controller, animated: isAnimated, completion: nil)
    }
    
}
