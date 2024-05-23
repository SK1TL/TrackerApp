//
//  CategoriesViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 15.05.2024.
//

import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func didSelectCategory(with name: String?)
}

final class CategoriesViewController: UIViewController {
    
    weak var delegate: CategoriesViewControllerDelegate?
    private let viewModel: CategoriesViewModel
    
    private var heightTableView: Int = 0
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium16()
        label.textColor = .YPBlack
        label.text = NSLocalizedString("category", comment: "")
        return label
    }()
    
    private lazy var emptyCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dizzy")
        return imageView
    }()
    
    private lazy var emptyCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium12()
        label.text = NSLocalizedString("emptyCategories.text", comment: "")
        label.numberOfLines = 2
        label.textColor = .YPBlack
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .YPGray
        tableView.backgroundColor = .YPWhite
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        return tableView
    }()
    
    private lazy var addCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("addCategory", comment: ""), for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPBlack
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addCategoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .YPWhite
        addSubviews()
        
        viewModel.$selectedCategoryName.bind { [weak self] _ in
            guard let self else { return }
            self.delegate?.didSelectCategory(with: self.viewModel.selectedCategoryName)
            self.tableView.reloadData()
        }
        
        viewModel.$categories.bind { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.categories?.count != 0 {
                self.tableView.isHidden = false
                self.emptyCategoryLabel.isHidden = true
                self.tableViewHeightConstraint?.constant = CGFloat(viewModel.categories!.count * 75)
                self.emptyCategoryImageView.isHidden = true
            } else {
                self.tableView.isHidden = true
                self.emptyCategoryLabel.isHidden = false
                self.emptyCategoryImageView.isHidden = false
            }
            
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
        }
        
        viewModel.$alertModel.bind { [weak self] alertModel in
            guard let self, let alertModel else { return }
            AlertPresenter().show(controller: self, model: alertModel)
        }
        
        if let categories = viewModel.categories, categories.count != 0 {
            heightTableView = categories.count * 75
            emptyCategoryLabel.isHidden = true
            emptyCategoryImageView.isHidden = true
        }
        makeConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, emptyCategoryImageView,
         emptyCategoryLabel, tableView, addCategoryButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightTableView))
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            emptyCategoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCategoryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyCategoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emptyCategoryImageView.bottomAnchor.constraint(equalTo: emptyCategoryLabel.topAnchor, constant: -8),
            emptyCategoryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCategoryImageView.heightAnchor.constraint(equalToConstant: 80),
            emptyCategoryImageView.widthAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 73),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableViewHeightConstraint!,
            
            addCategoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    // MARK: - Action private funс
    
    @objc private func addCategoryButtonTapped() {
        let newCategoryVC = NewCategoryViewController()
        newCategoryVC.delegate = self
        present(newCategoryVC, animated: true)
    }
    
    private func editCategory(_ category: TrackerCategory) {
        let newCategoryVC = NewCategoryViewController()
        newCategoryVC.delegate = self
        newCategoryVC.editingCategory = category
        present(newCategoryVC, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath),
            let categoryName = cell.textLabel?.text
        else { return }
        
        viewModel.selectCategory(with: categoryName)
        
        dismiss(animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let category = viewModel.categories?[indexPath.row] else { return nil }
        
        return UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(children: [
                UIAction(title: NSLocalizedString("edit", comment: "")) { [weak self] _ in
                    self?.editCategory(category)
                },
                UIAction(title: NSLocalizedString("delete", comment: ""), attributes: .destructive) { [weak self] _ in
                    self?.viewModel.showAlertToDelete(category)
                }
            ])
        })
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .ypBackground
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.categories?[indexPath.row].title
        cell.accessoryType = cell.textLabel?.text == viewModel.selectedCategoryName ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

// MARK: - NewCategoryViewControllerDelegate

extension CategoriesViewController: NewCategoryViewControllerDelegate {
    func create(newCategory: String?) {
        viewModel.addNewCategory(with: newCategory)
    }
    
    func update(editingCategory: String, with editedCategory: String) {
        viewModel.editCategory(from: editingCategory, with: editedCategory)
    }
}
