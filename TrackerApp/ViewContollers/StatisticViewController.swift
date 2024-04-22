//
//  StatisticViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

final class StatisticViewController: UIViewController {
    
    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Статистика"
        view.backgroundColor = .YPWhite
        
        addSubviews()
        makeConstraints()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .YPBlack
        
        guard let emptyStatisticImage = Resources.Images.emptyStatistic else { return }
        emptyView.configureView(image: emptyStatisticImage, text: "Анализировать пока нечего")
    }
    
    
    private func addSubviews() {
        view.addSubview(emptyView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
