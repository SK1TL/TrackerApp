//
//  NewCategoryViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 15.05.2024.
//

import UIKit

protocol NewCategoryViewControllerDelegate: AnyObject {
    func create(newCategory: String?)
    func update(editingCategory: String, with editedCategory: String)
}

final class NewCategoryViewController: UIViewController {
    
    weak var delegate: NewCategoryViewControllerDelegate?
    var editingCategory: TrackerCategory?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium16()
        label.textColor = .YPBlack
        label.text = NSLocalizedString("newCategory", comment: "")
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("enterCategoryName", comment: "")
        let leftInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        textField.leftView = leftInsetView
        textField.leftViewMode = .always
        textField.backgroundColor = .ypBackground
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("ready", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPGray
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .YPWhite
        textField.delegate = self
        textField.text = editingCategory?.title
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, textField, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    // MARK: - Action private funс
    
    @objc private func doneButtonTapped() {
        if textField.hasText, let category = textField.text {
            if editingCategory == nil {
                delegate?.create(newCategory: category)
            } else if let editingCategory = editingCategory {
                delegate?.update(editingCategory: editingCategory.title, with: category)
                self.editingCategory = nil
            }
            dismiss(animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        } else if textField.text?.isEmpty == true && !string.isEmpty {
            doneButton.backgroundColor = .YPBlack
            doneButton.setTitleColor(.YPWhite, for: .normal)
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            doneButton.backgroundColor = .YPGray
            doneButton.setTitleColor(.YPWhite, for: .normal)
        }
    }
}
