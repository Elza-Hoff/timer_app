//
//  TimerViewController+UITableView.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

//MARK: - UITableViewDelegate
extension TimerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * TableViewSizes.aspectRatioTimerRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * TableViewSizes.aspectRatioTimerRow
    }
    
}

//MARK: - UITableViewDataSource
extension TimerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCell.identifier, for: indexPath) as! TimerTableViewCell
        cell.timerDescription = self.viewModel.getCellTitle(for: indexPath)
        return cell
    }
    
}

//MARK: - TableViewSizes
extension TimerViewController {
    
    enum TableViewSizes {
        static let aspectRatioTimerRow: CGFloat = 0.2
    }
    
}
