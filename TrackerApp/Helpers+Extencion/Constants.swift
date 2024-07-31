//
//  Constants.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import Foundation
import UIKit

enum Constant {
    static let emojies: [String] = [
    "🏝️", "🥰", "🤩", "🥳", "✈️", "💯",
    "😈", "😻", "❤️", "👀", "💃", "👨‍👩‍👧‍👦",
    "🐶", "🪴", "🍎", "🥑", "🍷", "🛼",
    ]
    
    //ScheduleViewController
    static let scheduleTableViewTitles = [
        "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"
    ]
    
    static let colorSelection = (1...18).map({ UIColor(named: String($0)) })
    
    static let collectionViewTitles = ["Emoji", "Цвет"]
    
    static let metricaAPI = "3ea9f24f-52cc-4510-b582-88ec8cdf5d5f"
}

extension Constant {
    static func randomEmoji() -> String {
        return emojies.randomElement() ?? "❤️"
    }
}
