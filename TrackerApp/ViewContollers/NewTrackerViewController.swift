//
//  NewTrackerViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 23.04.2024.
//

import UIKit

protocol NewTrackerViewControllerDelegate: AnyObject {
    func addNewTrackerCategory(_ newTrackerCategory: TrackerCategory)
}

final class NewTrackerViewController: UIViewController {
    
    weak var delegate: NewTrackerViewControllerDelegate?
    var trackerType: TrackerType?
    
    private var emojiAndColorsCollection = EmojiAndColorsCollection()
    private var heightTableView: CGFloat = 74
    private var currentCategory: String?
    private var schedule: [WeekDays] = []
    private var switchDays: [WeekDays] = []
    private var trackerText = ""
    private var emoji = ""
    private var color: UIColor = .clear
    private var lastCategory = ""
    
    private var chosenName = false
    private var chosenCategory = false
    private var chosenSchedule = false
    private var chosenEmoji = false
    private var chosenColor = false
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .YPWhite
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium16()
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        switch trackerType {
        case .habitTracker: 
            label.text = NSLocalizedString("newHabit", comment: "")
        case .eventTracker:
            label.text = NSLocalizedString("newEvent", comment: "")
        case .none:
            break
        }
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = NSLocalizedString("tracker.name", comment: "")
        let leftInsertView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 30))
        textfield.leftView = leftInsertView
        textfield.leftViewMode = .always
        textfield.backgroundColor = .ypBackground
        textfield.layer.cornerRadius = 16
        textfield.clipsToBounds = true
        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .ypBackground
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.isScrollEnabled = false
        tableView.separatorColor = .YPGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        button.setTitleColor(.YPRed, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPWhite
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.YPRed.cgColor
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.titleLabel?.font = Resources.Fonts.ypMedium16()
        button.backgroundColor = .YPGray
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .YPWhite
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        addSubviews()
        makeConstraints()
        setupCollection()
    }
    
    // MARK: - Configure constraints / Add subviews
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        
        scrollView.addSubview(textField)
        scrollView.addSubview(tableView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(cancelButton)
        scrollView.addSubview(saveButton)
    }
    
    private func makeConstraints() {
        switch trackerType {
        case .eventTracker:
            heightTableView = 74
        case .habitTracker:
            heightTableView = 149
        case .none:
            break
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightTableView)),
            
            collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 484),
            
            cancelButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -4),
            cancelButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
            saveButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 4),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Private func
    
    private func setupCollection() {
        collectionView.register(
            SupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SupplementaryView.identifier
        )
        
        collectionView.register(
            EmojiAndColorsCollectionCell.self,
            forCellWithReuseIdentifier: EmojiAndColorsCollectionCell.reuseIdentifier
        )
        
        collectionView.delegate = emojiAndColorsCollection
        collectionView.dataSource = emojiAndColorsCollection
        emojiAndColorsCollection.delegate = self
    }
    
    private func buttonIsEnabled() {
        switch trackerType {
        case .habitTracker:
            if chosenName == true && chosenCategory == true && chosenSchedule == true && chosenEmoji == true && chosenColor == true {
                saveButton.backgroundColor = .YPBlack
                saveButton.setTitleColor(.YPWhite, for: .normal)
                saveButton.isEnabled = true
            } else {
                saveButton.backgroundColor = .YPGray
                saveButton.setTitleColor(.white, for: .normal)
            }
            
        case .eventTracker:
            if chosenName == true && chosenCategory == true && chosenEmoji == true && chosenColor == true {
                saveButton.backgroundColor = .YPBlack
                saveButton.setTitleColor(.YPWhite, for: .normal)
                saveButton.isEnabled = true
            } else {
                saveButton.backgroundColor = .YPGray
                saveButton.setTitleColor(.white, for: .normal)
            }
        case .none: break
        }
    }
    
    // MARK: - Action private func
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true) {
        }
    }
    
    @objc private func createButtonTapped() {
        guard let currentCategory else { return }
        
        dismiss(animated: true)
        delegate?.addNewTrackerCategory(
            TrackerCategory(
                title: currentCategory,
                trackers: [
                    Tracker(
                        id: UUID(),
                        text: textField.text ?? "",
                        emoji: emoji,
                        color: color,
                        schedule: schedule
                    )
                ]
            )
        )
    }
}

// MARK: - UITableViewDataSource

extension NewTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch trackerType {
        case .habitTracker:
            return 2
        case .eventTracker: 
            return 1
        case .none: 
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.detailTextLabel?.font = Resources.Fonts.ypRegular17()
        cell.detailTextLabel?.textColor = .YPGray
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = NSLocalizedString("category", comment: "")
            cell.detailTextLabel?.text = currentCategory
        case 1:
            cell.textLabel?.text = NSLocalizedString("schedule", comment: "")
            cell.detailTextLabel?.text = scheduleToString(for: schedule)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    private func scheduleToString(for: [WeekDays]) -> String {
        guard schedule.count != WeekDays.allCases.count else { return NSLocalizedString("everyDay", comment: "") }
        
        let scheduleSorted = schedule.sorted()
        let scheduleShortName = scheduleSorted.map { $0.shortName }.joined(separator: ", ")
        return scheduleShortName
    }
}

// MARK: - UITextFieldDelegate

extension NewTrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        trackerText = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        }
        chosenName = true
        switch trackerType {
        case .habitTracker:
            if schedule.isEmpty == false {
                buttonIsEnabled()
                return true
            }
        case .eventTracker:
            buttonIsEnabled()
            return true
        case .none:
            return true
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            saveButton.backgroundColor = .YPGray
            saveButton.setTitleColor(.YPWhite, for: .normal)
            saveButton.isEnabled = false
            chosenName = false
        }
    }
}

// MARK: - UITableViewDelegate

extension NewTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let categoriesVC = CategoriesAssembly().assemle(
                with: CategoryConfiguration(lastCategory: lastCategory)
            ) as? CategoriesViewController
            else { return }
            categoriesVC.delegate = self
            present(categoriesVC, animated: true)
        case 1:
            let scheduleVC = ScheduleViewController()
            scheduleVC.delegate = self
            scheduleVC.switchDays = switchDays
            present(scheduleVC, animated: true)
        default:
            break
        }
    }
}

// MARK: - ScheduleViewControllerDelegate

extension NewTrackerViewController: ScheduleViewControllerDelegate {
    func addNewSchedule(_ newSchedule: [WeekDays]) {
        schedule = newSchedule
        switchDays = newSchedule
        chosenSchedule = true
        tableView.reloadData()
        buttonIsEnabled()
    }
}

// MARK: - EmojiAndColorsCollectionDelegate

extension NewTrackerViewController: EmojiAndColorsCollectionDelegate {
    func addNewEmoji(_ emoji: String) {
        self.emoji = emoji
        chosenEmoji = true
        buttonIsEnabled()
    }
    
    func addNewColor(_ color: UIColor) {
        self.color = color
        chosenColor = true
        buttonIsEnabled()
    }
}

// MARK: - CategoriesViewControllerDelegate

extension NewTrackerViewController: CategoriesViewControllerDelegate {
    func didSelectCategory(with name: String?) {
        lastCategory = name ?? ""
        currentCategory = name
        chosenCategory = true
        buttonIsEnabled()
        tableView.reloadData()
    }
}
