//
//  RecipesResultCell.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import UIKit

class RecipesResultCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Properties
    
    var recipe: RecipeData.Hit.Recipe? {
        didSet {
            recipeTitleLabel.text = recipe?.label
            timeLabel.text = "\(recipe?.totalTime ?? 0)" + " min"
            yieldLabel.text = "\(recipe?.yield ?? 0)"
            ingredientLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            
            let urlRecipe = URL(string: recipe?.image ?? "")!
            recipeImageView.load(url: urlRecipe)
        }
    }
    
    var recipeEntity: RecipeEntity? {
        didSet {
            recipeTitleLabel.text = recipeEntity?.label
            timeLabel.text = (recipeEntity?.time ?? "") + " min"
            yieldLabel.text = recipeEntity?.yield
            ingredientLabel.text = recipeEntity?.ingredientLines?.joined(separator: ", ")
            
            let urlRecipe = URL(string: recipeEntity?.image ?? "")!
            recipeImageView.load(url: urlRecipe)
        }
    }
}
