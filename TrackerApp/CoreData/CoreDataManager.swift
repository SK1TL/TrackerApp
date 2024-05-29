//
//  CoreDataManager.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 27.05.2024.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
