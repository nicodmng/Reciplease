//
//  AddIngredientViewController.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import UIKit

class AddIngredientViewController: UIViewController {
    
    // MARK: - Properties
    
    private let service: RecipeService = RecipeService()
    private var ingredients = [String]()
    private var recipes: RecipeData?
    private let segueIdentifier = "segueToRecipesList"
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var listIngredientTextView: UITextView!
    @IBOutlet weak var AddIngredientView: UIView!
    
    @IBAction func addIngredientButton(_ sender: Any) {
        addIngredient()
    }

    @IBAction func clearButton(_ sender: Any) {
        listIngredientTextView.text = ""
        ingredients.removeAll()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        getRecipes()
        //searchButton.isEnabled = false
    }
    
    // MARK: - Methods
    
    func addIngredient() {
        guard
            let ingredient = ingredientTextField.text,
            var listIngredient = listIngredientTextView.text
        else { return }
        
        if ingredient .isEmpty {
            showAlert(message: "Please add some ingredients !")
        } else {
            
            listIngredient += "- " + ingredient + "\n"
            listIngredientTextView.text = listIngredient
            ingredientTextField.text = ""
            
            ingredients.append(ingredient)
        }
    }
    
    private func getRecipes() {
        if listIngredientTextView.text.isEmpty {
            showAlert(message: "Your list of ingredient is empty\n Please add an ingredient")
        } else {
            service.getRecipe(ingredients: ingredients) { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let recipes):
                        self.recipes = recipes
                        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
                        //self.searchButton.isEnabled = true
                    case .failure(let error):
                        //self.showAlert(message: error.description)
                        self.showAlert(message: "Erreur")
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let successVC = segue.destination as? TableViewController
            successVC?.hits = recipes?.hits
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowForIngredientView()
    }
}

    // MARK: - Extensions / UITextFieldDelegate

extension AddIngredientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboard() {
        ingredientTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func addShadowForIngredientView() {
        AddIngredientView.layer.cornerRadius = 6
        AddIngredientView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        AddIngredientView.layer.shadowRadius = 3.0
        AddIngredientView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        AddIngredientView.layer.shadowOpacity = 2.0
    }
}
