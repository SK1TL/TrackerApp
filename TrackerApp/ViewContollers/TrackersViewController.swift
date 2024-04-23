//
//  TrackerViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    private var currentDate = Date()
    private var completedTrackers: Set<TrackerRecord> = []
    private var categories: [TrackerCategory] = []
    private var visibleCategories: [TrackerCategory] = []
    private var textOfSearchQuery = ""
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar.firstWeekday = 2
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: Date())
        
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        datePicker.date = calendar.date(from: dateComponents) ?? Date()
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var searchBar: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.setValue("Отменить", forKey: "cancelButtonText")
        searchBar.placeholder = "Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchController
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchError")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        label.font = Resources.Fonts.ypMedium12()
        label.textAlignment = .center
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            TrackerCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackerCollectionViewCell.identifire
        )
        collectionView.register(
            HeaderCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionView.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        setupBar()
        addSubviews()
        setupViews()
        makeConstraints()
    }
    
    // MARK: - Configure constraints / Add subviews
    private func addSubviews() {
        view.addSubview(infoImageView)
        view.addSubview(infoLabel)
        view.addSubview(trackerCollectionView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            infoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoImageView.widthAnchor.constraint(equalToConstant: 80),
            infoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8),
            infoLabel.heightAnchor.constraint(equalToConstant: 18),
            
            trackerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trackerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackerCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Private func
    
    private func setupBar() {
        navigationItem.title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(addTracker))
        navigationItem.leftBarButtonItem?.tintColor = .YPBlack
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBar
    }
    
    private func setupViews() {
        trackerCollectionView.isHidden = categories.isEmpty
        infoLabel.isHidden = !categories.isEmpty
        infoLabel.text = "Что будем отслеживать?"
        infoImageView.image = Resources.Images.emptyTrackers
    }
    
    private func updateVisibleCategories() {
        var categoriesFiltered = categories.map { filterTreckerCategoryByDate(category: $0) }
        categoriesFiltered = categoriesFiltered.filter { !$0.trackers.isEmpty }
        if categoriesFiltered.isEmpty {
            if textOfSearchQuery.isEmpty {
                // Todo: испарвить потом согласно макету на "Ничего не найдено"
                infoLabel.text = "Ничего не найдено"
                infoImageView.image = Resources.Images.emptySearch
            }
        }
        visibleCategories = categoriesFiltered
        trackerCollectionView.reloadData()
    }
    
    private func filterTreckerCategoryByDate(category: TrackerCategory) -> TrackerCategory {
        let trackers = category.trackers.filter( { ($0.text.contains(textOfSearchQuery) || textOfSearchQuery.isEmpty) && ($0.schedule.contains(where: { $0.dayNumberOfWeek == currentDate.dayNumberOfWeek() }))})
        let filterCategory = TrackerCategory(title: category.title, trackers: trackers)
        return filterCategory
    }
    
    // MARK: - Action private funс
    
    @objc private func addTracker() {
        let typeNewTrackerVC = CreateTrackerViewCntroller(categories: categories)
        typeNewTrackerVC.delegate = self
        present(typeNewTrackerVC, animated: true)
    }
    
    @objc private func handleDatePicker() {
        currentDate = datePicker.date
        self.dismiss(animated: false)
        updateVisibleCategories()
    }
}

// MARK: - UISearchResultsUpdating
extension TrackersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        textOfSearchQuery = searchController.searchBar.text ?? ""
        updateVisibleCategories()
    }
}

// MARK: - UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        visibleCategories[section].trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerCollectionViewCell.identifire,
            for: indexPath
        ) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }

        let tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
        let daysCount = completedTrackers.filter{$0.id == tracker.id}.count
        let isDoneToday = completedTrackers.contains(where: {$0.date == currentDate})
        cell.delegate = self
        cell.configeCell(tracker: tracker)
        cell.configRecord(countDay: daysCount, isDoneToday: isDoneToday)
        return cell
      }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionView.identifier,
            for: indexPath
        ) as? HeaderCollectionView else {
            return UICollectionReusableView()
        }
        view.setTitle(visibleCategories[indexPath.section].title)
        return view
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        trackerCollectionView.isHidden = visibleCategories.count == 0
        return visibleCategories.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    private var lineSpacing: CGFloat { return 16 }
    private var interitemSpacing: CGFloat { return 9 }
    private var sideInset: CGFloat { return 16 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - interitemSpacing - 2 * sideInset) / 2
        return CGSize(width: width, height: 148)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )
        
        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width,
                   height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        interitemSpacing
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: sideInset, bottom: sideInset, right: sideInset)
    }
}

// MARK: - TrackerCollectionViewCellDelegate

extension TrackersViewController: TrackerCollectionViewCellDelegate {
    func didTapedDoneButton(cell: TrackerCollectionViewCell) {
        let indexPath: IndexPath = trackerCollectionView.indexPath(for: cell) ?? IndexPath()
        let id = visibleCategories[indexPath.section].trackers[indexPath.row].id
        var daysCount = completedTrackers.filter { $0.id == id }.count
        let completedTracker = TrackerRecord(id: id, date: datePicker.date)
        
        if  datePicker.date == Calendar.current.startOfDay(for: Date()) {
            if !completedTrackers.contains(completedTracker) {
                completedTrackers.insert(completedTracker)
                daysCount += 1
                cell.configRecord(countDay: daysCount, isDoneToday: true)
            } else {
                daysCount -= 1
                cell.configRecord(countDay: daysCount, isDoneToday: false)
                completedTrackers.remove(completedTracker)
            }
        }
    }
}

// MARK: - TypeNewTrackerDelegate

extension TrackersViewController: CreateTrackerViewCntrollerDelegate {
    func addNewTrackerCategory(_ newTrackerCategory: TrackerCategory) {
        dismiss(animated: true)
        var trackerCategory = newTrackerCategory
        if trackerCategory.trackers[0].schedule.isEmpty {
            guard let numberDay = currentDate.dayNumberOfWeek() else { return }
            var currentDay = numberDay
            if numberDay == 1 {
                currentDay = 8
            }
            let newSchedule = WeekDays.allCases[currentDay - 2]
            let updatedTracker = Tracker(id: trackerCategory.trackers[0].id,
                                           text: trackerCategory.trackers[0].text,
                                           emoji: trackerCategory.trackers[0].emoji,
                                           color: trackerCategory.trackers[0].color,
                                           schedule: trackerCategory.trackers[0].schedule + [newSchedule])
             
             var updatedTrackers = trackerCategory.trackers
             updatedTrackers[0] = updatedTracker
             
             trackerCategory = TrackerCategory(title: trackerCategory.title, trackers: updatedTrackers)
        }
        
        if categories.contains(where: { $0.title == trackerCategory.title}) {
            guard let index = categories.firstIndex(where: { $0.title == trackerCategory.title }) else { return }
            let oldCategory = categories[index]
            let updatedTrackers = oldCategory.trackers + trackerCategory.trackers
            let updatedTrackerByСategory = TrackerCategory(title: trackerCategory.title, trackers: updatedTrackers)
            
            categories[index] = updatedTrackerByСategory
        } else {
            categories.append(trackerCategory)
        }
        trackerCollectionView.reloadData()
        updateVisibleCategories()
    }
}

