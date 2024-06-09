//
//  SelectTypeEventViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import UIKit

protocol SelectTypeEventViewControllerDelegate: AnyObject {
    func didTapSelectTypeEventButton(isRegular: Bool)
}

final class SelectTypeEventViewController: UIViewController {
    weak var delegate: NewTrackerViewControllerDelegate?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("trackerCreation", comment: "")
        label.textAlignment = .center
        label.font = UIFont.ypMedium16()
        return label
    }()
    
    private lazy var addRegularEventButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .toggleBlackWhiteColor
        button.setTitleColor(UIColor.blackWhiteColorButton, for: .normal)
        button.setTitle(NSLocalizedString("habit", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.ypMedium16()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addIrregularEventButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .toggleBlackWhiteColor
        button.setTitleColor(UIColor.blackWhiteColorButton, for: .normal)
        button.setTitle(NSLocalizedString("event", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.ypMedium16()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapIrregularEventButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
    }
    
    @objc
    private func didTapHabitButton() {
        let createEventViewController = NewTrackerViewController(isRegular: true, isEditor: false)
        createEventViewController.delegate = delegate
        createEventViewController.modalPresentationStyle = .pageSheet
        present(createEventViewController, animated: true)
    }
    
    @objc
    private func didTapIrregularEventButton() {
        let createEventViewController = NewTrackerViewController(isRegular: false, isEditor: false)
        createEventViewController.delegate = delegate
        createEventViewController.modalPresentationStyle = .pageSheet
        present(createEventViewController, animated: true)
    }

    private func addSubviews() {
        view.backgroundColor = .ypWhite
        
        [titleLabel, addRegularEventButton, addIrregularEventButton].forEach {
            view.addViewsTAMIC($0)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            addRegularEventButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 295),
            addRegularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addRegularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addRegularEventButton.heightAnchor.constraint(equalToConstant: 60),
            
            addIrregularEventButton.topAnchor.constraint(equalTo: addRegularEventButton.bottomAnchor, constant: 16),
            addIrregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addIrregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addIrregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
