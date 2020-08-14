//
//  TimerViewController.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let title = "Timer"
    }
    
    //MARK: - Properties
        
    @IBOutlet weak private var vTimer: TimerPickerView!
    
    @IBOutlet weak private var btnAdd: CircleButton!
    
    @IBOutlet weak private var tfTimerTitle: UITextField!
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var vControlButtons: UIView!
    
    lazy var viewModel: TimerViewModel = {
        let model = TimerViewModel()
        model.delegate = self
        return model
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setControlPanel(hidden: true)
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavBar()
        self.add(title: Defaults.title)
        self.hideBackButton()
    }
    
    func setControlPanel(hidden: Bool) {
        self.vControlButtons.isHidden = hidden
    }
    
    func updateTableView() {
        return self.tableView.reloadData()
    }
    
    func scrollPickerView(row: Int, component: Int) {
        self.vTimer.select(row: row, component: component)
    }
    
    func setTimerViewInteractions(enabled: Bool) {
        self.vTimer.setInteraction(enabled: enabled)
    }
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: TimerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TimerTableViewCell.identifier)
    }
        
    private func configure() {
        self.vTimer.delegate = self
    }
    
    //MARK: - Handler
    
    @IBAction func didTouchAddButton(_ sender: Any) {
        self.viewModel.setTimer(with: "test")
    }
    
    @IBAction func didTouchCancelButton(_ sender: Any) {
        
    }
    
    @IBAction func didTouchPauseButton(_ sender: Any) {
        
    }
    
    
}

//MARK: - StoryboardInstantiable
extension TimerViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return Storyboard.timer
    }
    
}
