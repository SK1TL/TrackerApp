//
//  Date+Extencion.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import Foundation

extension Date {
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
    var formattedDate: String {
        dateFormatter.string(from: self)
    }
    
    var dayNumberOfWeek: Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    var dayNumber: Int? {
        Calendar.current.dateComponents([.day, .month, .year], from: self).day
    }
}
