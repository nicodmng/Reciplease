//
//  CoreDataServiceTests.swift
//  RecipleaseTests
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

@testable import Reciplease
import XCTest

final class CoreDataServiceTests: XCTestCase {

    // MARK: - Properties
    var coreDataStack: MockCoreDataStack!
    var coreDataService: CoreDataService!
    let recipe = Recipe(labelData: "Lemon", yieldData: "0", totalTimeData: "0", imageData: "https://www.apple.com", ingredientLinesData: ["Lemon"], urlData: "https://www.apple.com")
    
    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
        cleanDataBase()
    }

    override func tearDown() {
        super.tearDown()
        cleanDataBase()
        coreDataStack = nil
        coreDataService = nil
    }

    //MARK: - Tests

    func testAddRecipe_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {

        coreDataService.createFavoriteRecipe(recipe: recipe)
        XCTAssertTrue(!coreDataService.recipesFavorite.isEmpty)
        XCTAssertTrue(coreDataService.recipesFavorite[0].label == "Lemon")
    }
    
    func testDeleteAllRecipes_WhenAnEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {

        coreDataService.createFavoriteRecipe(recipe: recipe)
        coreDataService.deleteRecipe(label: recipe.labelData)
        XCTAssertEqual(coreDataService.recipesFavorite.count, 0)
        XCTAssertTrue(coreDataService.recipesFavorite.isEmpty)
    }
    
    func testDoNotAddRecipeWhenEntityHaveSameLabelName_ThenShouldBeNotAdd() {
        
        coreDataService.createFavoriteRecipe(recipe: recipe)
        coreDataService.isRecipeRegistered(label: "Lemon")
        coreDataService.recipesFavorite[0].label = recipe.labelData
        XCTAssertTrue(!coreDataService.recipesFavorite.isEmpty)
    }

    func cleanDataBase() {
        for entity in coreDataService.recipesFavorite {
            coreDataStack.mainContext.delete(entity)
        }
    }
}
