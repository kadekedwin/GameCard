//
//  Persistence.swift
//  GameCard
//
//  Created by Kadek Edwin on 24/08/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let game = Game(context: viewContext)
            game.id = UUID()
            game.name = "Test"
            game.datePublished = "2000"
            game.image = "https://c4.wallpaperflare.com/wallpaper/965/883/624/manga-one-piece-wallpaper-preview.jpg"
            game.desc = "Test desc"
            game.category = "Windows"
        }
        
        do {
            try viewContext.save()
            print("Data saved successfully")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GameCard")
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
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func addGame(name: String, datePublished: String, image: String, desc: String, category: String, context: NSManagedObjectContext) {
        let game = Game(context: context)
        game.id = UUID()
        game.name = name
        game.datePublished = datePublished
        game.image = image
        game.desc = desc
        game.category = category

        save(context: context)
    }
    
    func editGame(game: Game, name: String, datePublished: String, image: String, desc: String, category: String, context: NSManagedObjectContext) {
        game.name = name
        game.datePublished = datePublished
        game.image = image
        game.desc = desc
        game.category = category

        save(context: context)
    }
    
    func deleteGame(game: Game, context: NSManagedObjectContext) {
        context.delete(game)

        save(context: context)
    }
}
