//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Reciplease
import Foundation
import CoreData

final class MockCoreDataStack: CoreDataStack {

    // MARK: - Initializer
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }

    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        // self = réf. à la classe mère
        // persistentContainer remplacé par container
        self.persistentContainer = container
    }
}
