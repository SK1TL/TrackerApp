//
//  WeekDays.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation

enum WeekDays: String, Comparable, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var dayNumberOfWeek: Int {
        switch self {
        case .monday:
            return 2
        case .tuesday:
            return 3
        case .wednesday:
            return 4
        case .thursday:
            return 5
        case .friday:
            return 6
        case .saturday:
            return 7
        case .sunday:
            return 1
        }
    }
    
    var dayName: String {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }
    
    var shortName: String {
        switch self {
        case .monday:
            return NSLocalizedString("mo", comment: "")
        case .tuesday:
            return NSLocalizedString("tu", comment: "")
        case .wednesday:
            return NSLocalizedString("we", comment: "")
        case .thursday:
            return NSLocalizedString("th", comment: "")
        case .friday:
            return NSLocalizedString("fr", comment: "")
        case .saturday:
            return NSLocalizedString("sa", comment: "")
        case .sunday:
            return NSLocalizedString("mu", comment: "")
        }
    }
    
    private var sortOrder: Int {
        switch self {
        case .monday:
            return 0
        case .tuesday:
            return 1
        case .wednesday:
            return 2
        case .thursday:
            return 3
        case .friday:
            return 4
        case .saturday:
            return 5
        case .sunday:
            return 6
        }
    }
    
    static func < (lhs: WeekDays, rhs: WeekDays) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
    
    var localizedName: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
