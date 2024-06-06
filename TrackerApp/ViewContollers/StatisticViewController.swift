//
//  StatisticViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

final class StatisticViewController: UIViewController {
    
    private var viewModel: StatisticViewModel
    
    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            StatisticCell.self,
            forCellReuseIdentifier: StatisticCell.identifier
        )
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    init(viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("statistics", comment: "")
        view.backgroundColor = .YPWhite
        
        addSubviews()
        makeConstraints()
        bindingViewModel()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindingViewModel() {
        viewModel.$isEmptyPlaceholderHidden.bind { [weak self] isEmptyPlaceholderHidden in
            self?.toggleStatisticsPlaceholder(show: isEmptyPlaceholderHidden)
        }
        
        viewModel.$bestPeriod.bind { [weak self] newValue in
            self?.updateCellModel(for: .bestPeriod, value: newValue)
        }
        viewModel.$perfectDays.bind { [weak self] newValue in
            self?.updateCellModel(for: .perfectDays, value: newValue)
        }
        viewModel.$complitedTrackers.bind { [weak self] newValue in
            self?.updateCellModel(for: .complitedTrackers, value: newValue)
        }
        viewModel.$mediumValue.bind { [weak self] newValue in
            self?.updateCellModel(for: .mediumValue, value: newValue)
        }
    }
    
    private func updateCellModel(for statisticsCase: StatisticsCases, value: Int) {
        let cellModel = StatisticsCellModel(value: String(value), description: statisticsCase.description)
        
        if let index = viewModel.cellModels.firstIndex(where: { $0.description == statisticsCase.description }) {
            viewModel.cellModels[index] = cellModel
        } else {
            viewModel.cellModels.append(cellModel)
        }
        tableView.reloadData()
    }
    
    private func toggleStatisticsPlaceholder(show: Bool) {
        emptyView.isHidden = show
        tableView.isHidden = !show
    }
    
    private func addSubviews() {
        [emptyView, tableView].forEach { view.addSubview($0) }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 77),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 408)
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StatisticsCases.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.identifier, for: indexPath) as? StatisticCell else { return UITableViewCell() }
        
        let cellModel = viewModel.cellModels[indexPath.row]
        cell.configureCell(with: cellModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        102
    }
}
