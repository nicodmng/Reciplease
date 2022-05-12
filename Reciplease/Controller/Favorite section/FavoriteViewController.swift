//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import UIKit
import CoreData

class FavoriteViewController: UITableViewController {
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet var tableViewFavorite: UITableView!
    
    // MARK: - Properties
    
    var coreDataService: CoreDataService?
    var recipe: Recipe?
    
    let cellReuseIdentifier = "recipeCell"
    private let segueToRecipeDetail = "segueFromFavoriteToDetails"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipesResultCell", bundle: nil)
        tableViewFavorite.register(nibName, forCellReuseIdentifier: cellReuseIdentifier)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appDelegate.coreDataStack
        coreDataService = CoreDataService(coreDataStack: coredataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewFavorite.reloadData()
    }
    
    // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataService?.recipesFavorite.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
                as? RecipesResultCell else { return UITableViewCell() }
        
        let recipeFav = coreDataService?.recipesFavorite[indexPath.row]
        
        favoriteCell.recipeEntity = recipeFav
        
        return favoriteCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteRecipe = coreDataService?.recipesFavorite[indexPath.row] else { return }

        recipe = Recipe(entity: favoriteRecipe)
        
        performSegue(withIdentifier: "segueFromFavoriteToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFavoriteToDetails",
            let next = segue.destination as? RecipesDetailViewController {
            next.recipe = recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let coreData = coreDataService else { return }
        let removeRecipe = coreData.recipesFavorite[indexPath.row]
        guard let label = removeRecipe.label else { return }

        if editingStyle == .delete {
            coreData.deleteRecipe(label: label)
            tableViewFavorite.reloadData()
        }
    }
    
    // MARK: - Functions

    // Text if favorite is empty :
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let informationForUser = UILabel()
        informationForUser.text = "Favorites recipes list is empty"
        informationForUser.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        informationForUser.textAlignment = .center
        informationForUser.textColor = .darkGray
        return informationForUser
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataService?.recipesFavorite.isEmpty ?? true ? 400 : 0
    }
}

