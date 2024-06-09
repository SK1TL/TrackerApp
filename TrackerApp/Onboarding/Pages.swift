//
//  OnboardingPages.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 13.05.2024.
//

import Foundation

enum Pages: CaseIterable {
    case pageOne
    case pageTwo
    
    var title: String {
        switch self {
        case .pageOne:
            return NSLocalizedString("backgroundImage.blue.text", comment: "")
        case .pageTwo:
            return NSLocalizedString("backgroundImage.red.text", comment: "")
        }
    }
    
    var index: Int {
        switch self {
        case .pageOne:
            return 0
        case .pageTwo:
            return 1
        }
    }
}

