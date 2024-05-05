//
//  StoreError.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import Foundation

enum StoreError: Error {
    case decodingErrorInvalidCategoryTitle
    case decodingErrorInvalidTrackers
    case decodingErrorInvalidCategoryEntity
    case decodingErrorInvalidTrackerRecord
    case decodingErrorInvalidTracker
}
