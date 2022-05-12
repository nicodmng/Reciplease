//
//  CoreDataService.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import CoreData

// CRUD : Create / Read / Update / Delete
//service qui pilote toutes les actions que je vais devoir faire avec CoreData

final class CoreDataService {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    //Read
    var recipesFavorite: [RecipeEntity] {
        // récupère toutes les entités "Recipe ? Avec attributs ? :
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        // trie mes favoris en ordre alpha :
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        //execute la requête :
        guard let recipesFav = try? managedObjectContext.fetch(request) else { return [] }
        
        return recipesFav
    }
    
    // MARK: - Initializer
    
    // arrive en paramètre pour instancier mon CoreDataService :
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Recipe Entity
    
    //Create : modification de la BDD -> .saveContext() :
    func createFavoriteRecipe(recipe: Recipe) {
        
        let recipeEntity = RecipeEntity(context: managedObjectContext)
        
        recipeEntity.label = recipe.labelData
        recipeEntity.image = recipe.imageData
        recipeEntity.ingredientLines = recipe.ingredientLinesData
        recipeEntity.url = recipe.urlData
        recipeEntity.time = recipe.totalTimeData
        recipeEntity.yield = recipe.yieldData
        
        coreDataStack.saveContext()
    }
    
    func isRecipeRegistered(label: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else
        { return false }
        
        if favoritesRecipe.isEmpty
        { return false }
        
       return true
    }
    
    func deleteRecipe(label: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else
        { return }
        guard let recipe = favoritesRecipe.first else
        { return }
        managedObjectContext.delete(recipe)
        coreDataStack.saveContext()
    }
}
