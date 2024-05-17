//
//  Resources.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

enum Resources {
    
    // MARK: - UI element's SF symbols
    
    enum SfSymbols {
        static let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)
        static let addTracker = UIImage(systemName: "plus", withConfiguration: largeConfig)
        static let statistic = UIImage(systemName: "record.circle.fill")
        static let tracker = UIImage(systemName: "hare.fill")
        static let chevron = UIImage(systemName: "chevron.right")
        static let addCounter = UIImage(systemName: "plus")
        static let doneCounter = UIImage(systemName: "checkmark")
        static let pinTracker = UIImage(systemName: "pin")
    }
    
    // MARK: - UI element's images
    
    enum Images {
        static let emptySearch = UIImage(named: "searchEmoji")
        static let emptyTrackers = UIImage(named: "dizzy")
        static let emptyStatistic = UIImage(named: "cryEmoji")
    }
    
    // MARK: - Fonts
    
    enum Fonts {
        static func ypBold34() -> UIFont? {
            UIFont.systemFont(ofSize: 34, weight: .bold)
        }
        
        static func ypBold32() -> UIFont? {
            UIFont.systemFont(ofSize: 32, weight: .bold)
        }
        
        static func ypBold19() -> UIFont? {
            UIFont.systemFont(ofSize: 19, weight: .bold)
        }
        
        static func ypRegular17() -> UIFont? {
            UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        
        static func ypMedium16() -> UIFont? {
            UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        static func ypMedium12() -> UIFont? {
            UIFont.systemFont(ofSize: 12, weight: .medium)
        }
        
        static func ypMedium10() -> UIFont? {
            UIFont.systemFont(ofSize: 10, weight: .medium)
        }
    }
    // MARK: - Colors
    
    static let colors: [UIColor] = [
        .ypColorSelection01, .ypColorSelection02, .ypColorSelection03, .ypColorSelection04, .ypColorSelection05,
        .ypColorSelection06, .ypColorSelection07, .ypColorSelection08, .ypColorSelection09, .ypColorSelection10,
        .ypColorSelection11, .ypColorSelection12, .ypColorSelection13, .ypColorSelection14, .ypColorSelection15,
        .ypColorSelection16, .ypColorSelection17, .ypColorSelection18
    ]
    static let emojis: [String] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝️", "😪"
    ]
    static let textFieldLimit = 38
}
