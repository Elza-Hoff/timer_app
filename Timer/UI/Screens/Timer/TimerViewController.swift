//
//  TimerViewController.swift
//  Timer
//
//  Created by Yelyzaveta Kartseva on 13.08.2020.
//  Copyright © 2020 Yelyzaveta Kartseva. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController, ErrorToastProtocol {
    
    //MARK: - Defaults
    
    private enum Defaults {
        static let title = "Timer"
        static let resume = "Resume"
    }
    
    //MARK: - Properties
        
    @IBOutlet weak private var vTimer: TimerPickerView!
    
    @IBOutlet weak private var btnAdd: CircleButton!
    
    @IBOutlet weak private var btnPause: RoundedButton!
    
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
        self.refreshViewModelTimersData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavBar()
        self.add(title: Defaults.title)
        self.hideBackButton()
    }
    
    func updateTableView() {
        return self.tableView.reloadData()
    }
    
    func scrollPickerView(row: Int, component: Int) {
        self.vTimer.select(row: row, component: component)
    }
    
    func prepareTimeUIFor(start: Bool) {
        self.setControlPanel(hidden: !start)
        self.setTimerViewInteractions(enabled: !start)
        self.setAddButtom(enabled: !start)
        self.setPauseButton(selected: !start)
    }
    
    func resetPickerViewToStartState() {
        self.scrollPickerView(row: 0, component: Time.hours.rawValue)
        self.scrollPickerView(row: 0, component: Time.minutes.rawValue)
        self.scrollPickerView(row: 0, component: Time.seconds.rawValue)
    }
    
    private func setControlPanel(hidden: Bool) {
        self.vControlButtons.isHidden = hidden
    }
    
    private func setTimerViewInteractions(enabled: Bool) {
        self.vTimer.setInteraction(enabled: enabled)
    }
    
    private func setAddButtom(enabled: Bool) {
        self.btnAdd.isUserInteractionEnabled = enabled
    }
    
    private func setPauseButton(selected: Bool) {
        self.btnPause.isSelected = selected
    }
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: TimerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TimerTableViewCell.identifier)
    }
        
    private func configure() {
        self.vTimer.delegate = self
        self.btnPause.setTitle(Defaults.resume, for: .selected)
    }
    
    private func refreshViewModelTimersData() {
        self.viewModel.fetchAllTimers()
    }
    
    //MARK: - Handler
    
    @IBAction func didTouchAddButton(_ sender: Any) {
        self.prepareTimeUIFor(start: true)
        self.viewModel.setTimer(with: self.tfTimerTitle.text)
    }
    
    @IBAction func didTouchCancelButton(_ sender: Any) {
        self.viewModel.killTimer()
    }
    
    @IBAction func didTouchPauseButton(_ sender: Any) {
        self.btnPause.isSelected = !self.btnPause.isSelected
        if self.btnPause.isSelected {
            self.viewModel.pauseTimer()
        } else {
            self.viewModel.resumeTimer()
        }
    }
    
    
}

//MARK: - StoryboardInstantiable
extension TimerViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return Storyboard.timer
    }
    
}
