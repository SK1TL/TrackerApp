//
//  ScheduleViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 23.04.2024.
//

import UIKit

protocol ScheduleViewControllerDelegate: AnyObject {
    func addNewSchedule(_ newSchedule: [WeekDays])
}

final class ScheduleViewController: UIViewController, UITableViewDelegate {
    
    weak var delegate: ScheduleViewControllerDelegate?
    var switchDays: [WeekDays] = []
    private var week = WeekDays.allCases
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium16()
        label.text = "Расписание"
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .YPGray
        tableView.backgroundColor = .YPWhite
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var completedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPGray
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(completedButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Configure constraints / Add subviews
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(completedButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 73),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 524),
            
            completedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            completedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completedButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    // MARK: - Action private func
    
    @objc private func completedButtonTapped() {
        self.delegate?.addNewSchedule(self.switchDays)
        dismiss(animated: true)
    }
    
    @objc private func switchTap(_ sender: UISwitch) {
        if sender.isOn {
            switchDays.append(week[sender.tag])
        } else {
            if let index = switchDays.firstIndex(of: week[sender.tag]) {
                switchDays.remove(at: index)
            }
        }
        buttonIsEnabled(!switchDays.isEmpty)
    }
}

// MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WeekDays.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switcher = UISwitch()
        switcher.onTintColor = .YPBlue
        switcher.tag = indexPath.row
        switcher.addTarget(self, action: #selector(switchTap), for: .valueChanged)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.backgroundColor = .ypBackground
        cell.textLabel?.text = week[indexPath.row].dayName
        cell.textLabel?.font = Resources.Fonts.ypRegular17()
        cell.accessoryView = switcher
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    // MARK: - Private func
    
    private func buttonIsEnabled(_ isOn: Bool) {
        completedButton.isEnabled = isOn
        completedButton.backgroundColor = isOn ? .YPBlack : .YPGray        
        completedButton.setTitleColor(.YPWhite, for: .normal)
    }
}
