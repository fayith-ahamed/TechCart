//
//  CoreDataStack.swift
//  TechCart
//
//  Created by Fayith  on 11/09/26.
//

import CoreData

final class CoreDataStack {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "TechCart")
        
        if inMemory {
            
            let description = NSPersistentStoreDescription()
            
            description.url = URL(fileURLWithPath: "/dev/null")
            
            persistentContainer.persistentStoreDescriptions = [description]
            
            
        }
        
        persistentContainer.loadPersistentStores { _ , error in
            
            if let error {
                
                fatalError("Core Data failed to load: \(error)")
            }
            
            
            
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
}
