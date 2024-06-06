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
        tabBar.backgroundColor = .YPWhite
        tabBar.barTintColor = .YPWhite
        tabBar.tintColor = .YPBlue
        tabBar.unselectedItemTintColor = .YPGray
        
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.YPGray.cgColor
        tabBar.clipsToBounds = true
        
        let trackerViewController = UINavigationController(rootViewController: TrackersViewController())
        
        trackerViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("trackers", comment: ""),
            image: Resources.SfSymbols.tracker?.withTintColor(.YPGray),
            selectedImage: Resources.SfSymbols.tracker?.withTintColor(.YPBlue)
        )
        
        let statisticViewController = UINavigationController(rootViewController: StatisticViewController(viewModel: StatisticViewModel()))
        
        statisticViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("statistics", comment: ""),
            image: Resources.SfSymbols.statistic?.withTintColor(.YPGray),
            selectedImage: Resources.SfSymbols.statistic?.withTintColor(.YPBlue)
        )
        
        selectedIndex = 0
        viewControllers = [trackerViewController, statisticViewController]
    }
}
