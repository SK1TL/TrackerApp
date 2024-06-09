//
//  TabBarController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        case tracker
        case statistic
        
        var title: String {
            switch self {
            case .tracker:
                return NSLocalizedString("trackers", comment: "")
            case .statistic:
                return NSLocalizedString("statistics", comment: "")
            }
        }
        
        var iconName: String {
            switch self {
            case .tracker:
                return "record.circle.fill"
            case .statistic:
                return "hare.fill"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .ypWhite
        
        let dataSource: [TabBarItem] = [.tracker, .statistic]
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        lineView.backgroundColor = UIColor.tabBarBorderLineColor
        tabBar.insertSubview(lineView, at: 0)

        tabBar.barTintColor = .ypGray
        tabBar.barTintColor = .ypBlue
        tabBar.backgroundColor = .ypWhite
        
        self.viewControllers = dataSource.map {
            switch $0 {
            case .tracker:
                return TrackersViewController(trackerStore: TrackerStore())
            case .statistic:
                return StatisticViewController(viewModel: StatisticsViewModel())
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
        }
    }
}
