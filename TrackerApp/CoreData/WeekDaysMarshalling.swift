//
//  WeekDaysMarshalling.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import Foundation

final class WeekDaysMarshalling {
    
    func convertWeekDaysToString(_ days: [WeekDays]) -> String {
        let shedule = days.map{ $0.rawValue + " "}.joined()
        return shedule
    }
    
    func convertStringToWeekDays(_ string: String?) -> [WeekDays] {
        guard let sheduleStringArray = string?.components(separatedBy: [" "]) else { return []}
        let sheduleArray = sheduleStringArray.compactMap{ WeekDays(rawValue: $0) }
        return sheduleArray
    }
}
