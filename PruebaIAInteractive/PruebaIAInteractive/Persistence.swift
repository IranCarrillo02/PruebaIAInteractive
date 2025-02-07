//
//  Persistence.swift
//  PruebaIAInteractive
//
//  Created by IRAN CARRILLO GUZMAN on 07/02/25.
//

import CoreData
import CoreTransferable

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newGame = VideoGameEntity(context: viewContext)
            newGame.title = "Juego de prueba"
            newGame.developer = "Desarrollador X"
            newGame.freetogame_profile_url = "https://example.com"
            newGame.game_url = "https://example.com"
            newGame.genre = "MMORPG"
            newGame.id = Int32.random(in: 1...1000)
            newGame.platform = "PC"
            newGame.publisher = "Publicador X"
            newGame.release_date = "2024-06-22"
            newGame.short_description = "Descripción de prueba"
            newGame.thumbnail = "https://example.com/image.jpg"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PruebaIAInteractive")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
