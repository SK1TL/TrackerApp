//
//   InitialViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import UIKit

final class InitialViewController: UIViewController {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case onboardingShown
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let onboardingShown = userDefaults.bool(forKey: Keys.onboardingShown.rawValue)
        
        if !onboardingShown {
            let onboardingVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: false)
        
            userDefaults.set(true, forKey: Keys.onboardingShown.rawValue)
        } else {
            let tabBarVC = TabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: false)
        }
    }
}
