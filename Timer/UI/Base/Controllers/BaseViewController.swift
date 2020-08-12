//
//  BaseViewController.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Defaults
    
    enum Controller {
        case timer
        
        var rawValue: UIViewController {
            switch self {
            case .timer: return UIViewController()
            }
        }
        
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func load(controller: Controller) {
        if self.navigationController?.topViewController?.className == controller.rawValue.className {
            dismiss(animated: true, completion: nil)
            return
        }
        self.navigationController?.pushViewController(controller.rawValue, animated: true)
    }
}

//MARK: - UIStatusBarStyle
extension BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

//MARK: - UINavigationControllerDelegate
extension BaseViewController: UINavigationControllerDelegate {
    
}
