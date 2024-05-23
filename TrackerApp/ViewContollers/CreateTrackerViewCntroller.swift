//
//  CreateTrackerViewCntroller.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 23.04.2024.
//

import UIKit

protocol CreateTrackerViewCntrollerDelegate: AnyObject {
    func addNewTrackerCategory(_ newTrackerCategory: TrackerCategory)
}

final class CreateTrackerViewCntroller: UIViewController {
    
    private let categories: [TrackerCategory]
    
    var trackerType: TrackerType?
    
    weak var delegate: CreateTrackerViewCntrollerDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium16()
        label.textColor = .YPBlack
        label.text = NSLocalizedString("trackerCreation", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var newHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("habit", comment: ""), for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPBlack
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(newHabitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("event", comment: ""), for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPBlack
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(newEventButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(categories: [TrackerCategory]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(newHabitButton)
        verticalStackView.addArrangedSubview(newEventButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            newHabitButton.heightAnchor.constraint(equalToConstant: 60),
            newEventButton.heightAnchor.constraint(equalTo: newHabitButton.heightAnchor),
            
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func newHabitButtonTapped() {
        let newTrackerVC = NewTrackerViewController()
        newTrackerVC.trackerType = .habitTracker
        newTrackerVC.delegate = self
        present(newTrackerVC, animated: true)
    }
    
    @objc private func newEventButtonTapped() {
        let newTrackerVC = NewTrackerViewController()
        newTrackerVC.trackerType = .eventTracker
        newTrackerVC.delegate = self
        present(newTrackerVC, animated: true)
    }
}

extension CreateTrackerViewCntroller: NewTrackerViewControllerDelegate {
    func addNewTrackerCategory(_ newTrackerCategory: TrackerCategory) {
        delegate?.addNewTrackerCategory(newTrackerCategory)
        dismiss(animated: true)
    }
}
