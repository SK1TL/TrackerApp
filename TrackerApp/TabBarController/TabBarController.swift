//
//  TabBarController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .YPWhite
        tabBar.tintColor = .YPBlue
        tabBar.unselectedItemTintColor = .YPGray
        
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.YPGray.cgColor
        tabBar.clipsToBounds = true
        
        let trackerViewController = UINavigationController(rootViewController: TrackerViewController())
        
        trackerViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: Resources.SfSymbols.tracker?.withTintColor(.YPGray),
            selectedImage: Resources.SfSymbols.tracker?.withTintColor(.YPBlue)
        )
        
        let statisticViewController = UINavigationController(rootViewController: StatisticViewController())
        
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: Resources.SfSymbols.statistic?.withTintColor(.YPGray),
            selectedImage: Resources.SfSymbols.statistic?.withTintColor(.YPBlue)
        )
        
        selectedIndex = 0
        viewControllers = [trackerViewController, statisticViewController]
    }
}
