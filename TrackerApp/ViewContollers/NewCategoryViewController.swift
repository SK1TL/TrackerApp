//
//  NewCategoryViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 15.05.2024.
//

import UIKit

protocol CreateCategoryViewControllerDelegate: AnyObject {
    func addCategory(newCategoryLabel: String)
}

final class CreateCategoryViewController: UIViewController {
    
    weak var delegate: CreateCategoryViewControllerDelegate?
    private var newTrackerCategory: TrackerCategory?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("newCategory", comment: "")
        label.font = UIFont.ypMedium16()
        label.textColor = .toggleBlackWhiteColor
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.layer.masksToBounds = true
        field.placeholder = NSLocalizedString("enterCategoryName", comment: "")
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.layer.cornerRadius = 16
        field.backgroundColor = .ypBackground
        field.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return field
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.blackGrayColorButton, for: .normal)
        button.backgroundColor = .ypGray
        button.isEnabled = false
        button.setTitle(NSLocalizedString("ready", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.ypMedium16()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapСonfirmButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = newTrackerCategory?.title
        textField.delegate = self
        
        addSubviews()
        setConstraints()
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc
    private func didTapСonfirmButton() {
        if textField.hasText {
            if let category = textField.text {
                if newTrackerCategory == nil {
                    delegate?.addCategory(newCategoryLabel: category)
                } else {
                    newTrackerCategory = nil
                }
                dismiss(animated: true)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension CreateCategoryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.hasText {
            confirmButton.backgroundColor = .toggleBlackWhiteColor
            confirmButton.isEnabled = true
        } else {
            confirmButton.backgroundColor = .ypGray
            confirmButton.isEnabled = false
        }
    }
}

// MARK: - Set constraints / Add subviews

extension CreateCategoryViewController {
    
    private func addSubviews() {
        view.backgroundColor = .ypWhite
        
        [titleLabel, confirmButton,textField].forEach {view.addViewsWithTranslatesAutoresizingMask($0)}
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            textField.heightAnchor.constraint(equalToConstant: 75),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
