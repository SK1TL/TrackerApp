//
//  WeekDays.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation

enum WeekDays: String, CaseIterable, Comparable {
    
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
    case sunday = "sunday"
    
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
            return NSLocalizedString("su", comment: "")
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
    
    var localizedName: String {
        NSLocalizedString(rawValue, comment: "")
    }
    
    static func < (lhs: WeekDays, rhs: WeekDays) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

extension WeekDays {
    static func code(_ weekdays: [WeekDays]?) -> String? {
        guard let weekdays else { return nil }
        let indexes = weekdays.map { Self.allCases.firstIndex(of: $0) }
        var result = ""
        for i in 0..<7 {
            if indexes.contains(i) {
                result += "1"
            } else {
                result += "0"
            }
        }
        return result
    }
    
    static func decode(from string: String?) -> [WeekDays]? {
        guard let string else { return nil }
        var weekdays = [WeekDays]()
        for (index, value) in string.enumerated() {
            guard value == "1" else { continue }
            let weekday = Self.allCases[index]
            weekdays.append(weekday)
        }
        return weekdays
    }
}
