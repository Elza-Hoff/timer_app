//
//  TimerTableViewCell.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak private var lblTimerDescription: UILabel!
    
    var timerDescription: String? {
        didSet {
            self.lblTimerDescription.text = self.timerDescription
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.timerDescription = nil
    }
}

//MARK: - AutoIndentifierCell
extension TimerTableViewCell: AutoIndentifierCell {}
