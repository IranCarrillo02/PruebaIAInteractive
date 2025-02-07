//
//  CoreDataManager.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
        private init() {}
        
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "VideoGameCatalog")
            container.loadPersistentStores { description, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()
        
        var context: NSManagedObjectContext {
            return persistentContainer.viewContext
        }
        
        func saveContext() {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}
