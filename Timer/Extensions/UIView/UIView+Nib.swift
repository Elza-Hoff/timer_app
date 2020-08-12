//
//  UIView+Nib.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 12.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit
import QuickLayout

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(type(of: self).className, owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }

}
