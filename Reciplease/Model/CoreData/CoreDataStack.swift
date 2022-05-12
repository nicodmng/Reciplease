//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    // MARK: - Properties
    
    private let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    private let persistentContainerName = "Reciplease"
    
    // MARK: - CoreDataStack
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    // variable lazy créée afin d'accéder plus facilement au contexte :
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

