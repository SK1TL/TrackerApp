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
        let categoryStore = TrackerCategoryStore(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        let lastCategory = configuration.lastCategory
        let viewModel = CategoriesViewModel(categoryStore: categoryStore, lastCategory: lastCategory)
        let viewController = CategoriesViewController(viewModel: viewModel)
        return viewController
    }
}
