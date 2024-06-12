//
//  FilterTrackerViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 06.06.2024.
//

import UIKit

enum FilterType: CaseIterable {
    case allTrackers
    case trackersOnToday
    case completed
    case uncompleted

    var title: String {
        switch self {
        case .allTrackers:
            return "Все трекеры"
        case .trackersOnToday:
            return "Трекеры на сегодня"
        case .completed:
            return "Завершенные"
        case .uncompleted:
            return "Не завершенные"
        }
    }
}

final class FilterTrackerViewController: UIViewController {
    var tableView: UITableView!
    
    let filters = FilterType.allCases// ["Все трекеры", "Трекеры на сегодня", "Завершенные", "Не завершенные"]
    var selectedFilter: FilterType = .trackersOnToday
    var onFilterSelected: ((FilterType) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureConstraints()
        configureNavBar()
        view.backgroundColor = UIColor.blackWhiteColorCell
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
    
    private func configureNavBar(){
        navigationItem.title = NSLocalizedString("filters", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.toggleBlackWhiteColor]
    }
}

extension FilterTrackerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filters[indexPath.row].title
        cell.accessoryType = selectedFilter == filters[indexPath.row] ? .checkmark : .none
        cell.backgroundColor = .ypGray.withAlphaComponent(0.3)
        cell.textLabel?.font = UIFont.ypRegular17()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 0
        cell.layer.maskedCorners = []
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilter = filters[indexPath.row]
        tableView.reloadData()
        onFilterSelected?(selectedFilter)
        dismiss(animated: true, completion: nil)
    }
}

