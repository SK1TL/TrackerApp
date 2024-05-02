//
//  TrackerRecordStore.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import Foundation
import CoreData

final class TrackerRecordStore: NSObject {
    private let context: NSManagedObjectContext
    private let trackerStore = TrackerStore()
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    var records: Set<TrackerRecord> {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.returnsObjectsAsFaults = false
        let objects = try? context.fetch(request)
        var recordsSet: Set<TrackerRecord> = []
        if let objects {
            for i in objects {
                guard let record = try? makeTrackerRecord(from: i) else { return [] }
                recordsSet.insert(record)
            }
        }
        
        return recordsSet
    }
    
    func add(_ newRecord: TrackerRecord) throws {
        let trackerCoreData = try trackerStore.fetchTracker(with: newRecord.id)
        let trackerRecordCoreData = TrackerRecordCoreData(context: context)
        trackerRecordCoreData.recordId = newRecord.id
        trackerRecordCoreData.recordDate = newRecord.date
        trackerRecordCoreData.tracker = trackerCoreData
        
        try context.save()
    }
    
    func remove(_ record: TrackerRecord) throws {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.predicate = NSPredicate(format: "%K == %@",#keyPath(TrackerRecordCoreData.recordId),record.id.uuidString)
        let records = try context.fetch(request)
        guard let recordToRemove = records.first else { return }
        context.delete(recordToRemove)
        try context.save()
    }
    
    private func makeTrackerRecord(from coreData: TrackerRecordCoreData) throws -> TrackerRecord {
        guard
            let id = coreData.recordId,
            let date = coreData.recordDate
        else { throw StoreError.decodingErrorInvalidTrackerRecord }

        return TrackerRecord(id: id, date: date)
    }
}
