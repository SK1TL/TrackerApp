//
//  Date+Extencion.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func dayNumber() -> Int? {
        return Calendar.current.dateComponents([.day, .month, .year], from: self).day
    }
}
