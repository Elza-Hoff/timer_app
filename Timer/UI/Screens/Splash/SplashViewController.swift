//
//  SplashViewController.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import Foundation

class SplashViewController: BaseViewController {
    
    // MARK: - Setters
        
    private(set) var scene: Scene! = .none {
        didSet {
            self.isReadyWorkspace = true
        }
    }
    
    private var isReadyWorkspace: Bool = false {
        didSet {
            if self.isReadyWorkspace {
                self.didReadyWorkspace?()
                self.loadScene(self.scene)
            }
        }
    }
    
    // MARK: - Callbacks
    
    private var didReadyWorkspace: (() -> ())? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareWorkspace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

// MARK: - Private

extension SplashViewController {
    
    private func prepareWorkspace() {
        self.prepareUserWorkspace()
    }

    private func prepareUserWorkspace() {
        self.scene = Scene.main
    }

}

// MARK: - UIStatusBarStyle
//
//extension SplashViewController {
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
//    
//}


//MARK: - StoryboardInstantiable
extension SplashViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return Storyboard.splash
    }
    
}
