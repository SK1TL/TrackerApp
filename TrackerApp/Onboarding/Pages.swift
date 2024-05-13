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
            return "Отслеживайте только то, что хотите"
        case .pageTwo:
            return "Даже если это не литры воды и йога"
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
