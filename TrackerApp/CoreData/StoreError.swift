//
//  StoreError.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import Foundation

enum StoreError: Error {
    case decodeCategoryStoreError
    case decodeTrackerStoreError
    case decodeRecordStoreError
    case deleteError
    case pinError
    case updateError
    case getRecordError
    case saveRecordError
    case deleteRecordError
    case decodeError
    case fetchCategoryError
}
