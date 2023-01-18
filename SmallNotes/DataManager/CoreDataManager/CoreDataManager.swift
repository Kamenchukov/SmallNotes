//
//  CoreDataManager.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import CoreData

class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "SmallNotes")
        loadPersistentStores()
    }
    
    func loadPersistentStores() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                print("Error, loading data: \(error!.localizedDescription)")
                return
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error while saving: \(error.localizedDescription)")
            }
        }
    }
    
    func sortFetchNotes() -> [NSSortDescriptor] {
        let dataSort = NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)
        return [dataSort]
    }
    
    func fetchData() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = sortFetchNotes()
        
        var notes: [Item] = []
        do {
            notes = try viewContext.fetch(request)
        } catch let error {
            print("Error:\(error.localizedDescription)")
        }
        return notes
    }
    
    func deleteAllData() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let allNotes = try viewContext.fetch(request)
            for note in allNotes {
                viewContext.delete(note)
            }
        } catch let error {
            print("Error while deleting: \(error.localizedDescription)")
        }
        save()
    }
}

