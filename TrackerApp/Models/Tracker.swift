//
//  Tracker.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

struct Tracker {
    let id: UUID
    let text: String
    let emoji: String
    let color: UIColor
    var schedule: [WeekDays]?
    let completedDaysCount: Int
    var isPinned: Bool
    let category: TrackerCategory
    
    init(id: UUID = UUID(), color: UIColor, text: String, emoji: String, completedDaysCount: Int, schedule: [WeekDays]?, isPinned: Bool, category: TrackerCategory) {
        self.id = id
        self.color = color
        self.text = text
        self.emoji = emoji
        self.completedDaysCount = completedDaysCount
        self.schedule = schedule
        self.isPinned = isPinned
        self.category = category
    }
}
