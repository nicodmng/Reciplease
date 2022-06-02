//
//  TableViewController.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var hits: [RecipeData.Hit]?
    var nextPageUrl: String?
    var recipe: Recipe?
    private var recipes: RecipeData?
    var recipeService = RecipeService()
    
    private let segueToRecipeDetail = "segueToRecipeDetailFirst"
    let cellReuseIdentifier = "recipeCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecipesResultCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    // MARK: - Tableview DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipesResultCell
        else { return UITableViewCell() }
        
        cell.recipe = hits?[indexPath.row].recipe
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hits = hits else { return }
        
        let recipe = hits[indexPath.row].recipe
        
        self.recipe = Recipe(labelData: recipe.label, yieldData: String(recipe.yield ?? 0), totalTimeData: String(recipe.totalTime ?? 0), imageData: recipe.image, ingredientLinesData: recipe.ingredientLines, urlData: recipe.url)
        
        performSegue(withIdentifier: "segueToRecipeDetailFirst", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeDetailFirst",
           let next = segue.destination as? RecipesDetailViewController {
            next.recipe = recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let hits = hits else { return }
        
        if hits.count - 1 == indexPath.row {
            guard let nextPage = nextPageUrl else { return }
            recipeService.nextRecipes(url: nextPage) { [weak self] result in
                switch result {
                case.success(let recipes):
                    self?.hits! += recipes.hits
                    self?.nextPageUrl = recipes.links?.next.href
                    self?.tableView.reloadData()
                case .failure (let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
}
