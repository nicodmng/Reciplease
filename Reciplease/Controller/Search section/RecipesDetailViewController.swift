//
//  RecipesDetailViewController.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import UIKit

class RecipesDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipe: Recipe?
    var coreDataService: CoreDataService?
    let cellReuseIdentifierDetail = "cell"
    
    var favoriteImage: UIImage {
        return UIImage(systemName: "star.fill")!
    }
    
    var unfavoriteImage: UIImage {
        return UIImage(systemName: "star")!
    }
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var ingredientsList: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBAction func goToRecipe(_ sender: Any) {
        goToRecipe()
    }
    
    @IBAction func favoriteRecipePressed(_ sender: UIBarButtonItem) {
        favoriteButton.image = favoriteImage
        addToFavorites()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
        
        displayDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if coreDataService?.isRecipeRegistered(label: recipe?.labelData ?? "") == true {
            favoriteButton.image = favoriteImage
        } else {
            favoriteButton.image = unfavoriteImage
        }
    }
    
    // MARK: - Methods
    
    func displayDetails() {
        recipeTitleLabel.text = recipe?.labelData
        
        guard let recipeInfo = recipe else { return }
        guard let urlRecipe = URL(string: recipeInfo.imageData) else { return }
        recipeImage.load(url: urlRecipe)
        
        recipeTitleLabel.text = recipe?.labelData
        
        // Get ingredients list :
        self.ingredientsList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifierDetail)
        
        // Delegate & DataSource :
        ingredientsList.delegate = self
        ingredientsList.dataSource = self
    }
        
    func addToFavorites() {
        guard let recipe = recipe else { return }
        guard let coreDataService = coreDataService else { return }
        
        if coreDataService.isRecipeRegistered(label: recipe.labelData) {
            coreDataService.deleteRecipe(label: recipe.labelData)
            favoriteButton.image = unfavoriteImage
        } else {
            coreDataService.createFavoriteRecipe(recipe: recipe)
            favoriteButton.image = favoriteImage
        }
    }
    
    func goToRecipe() {
        if let url = URL(string: recipe!.urlData) {
            UIApplication.shared.open(url)
        }
    }
    
}

    // MARK: - Extensions

extension RecipesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLinesData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.ingredientsList.dequeueReusableCell(withIdentifier: cellReuseIdentifierDetail, for: indexPath)
        cell.textLabel?.text = self.recipe?.ingredientLinesData[indexPath.row]
        
        return cell
    }
}
