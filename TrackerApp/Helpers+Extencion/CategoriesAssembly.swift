//
//  CategoriesAssembly.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 15.05.2024.
//

import UIKit

struct CategoryConfiguration {
    let lastCategory: String?
}

final class CategoriesAssembly {
    func assemle(with configuration: CategoryConfiguration) -> UIViewController {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return UIViewController() }
        let categoryStore = try! TrackerCategoryStore(
            context: appDelegate.persistentContainer.viewContext
        )
        let lastCategory = configuration.lastCategory
        let viewModel = CategoriesViewModel(trackerCategoryStore: categoryStore, lastCategory: lastCategory)
        let viewController = CategoriesViewController(viewModel: viewModel)
        return viewController
    }
}
