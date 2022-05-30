//
//  RecipeData.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

struct RecipeData: Decodable {
    let hits: [Hit]
    
    struct Hit: Decodable {
        let recipe: Recipe
        let links: WelcomeLinks
        
        struct Recipe: Decodable {
            let label: String
            let yield: Int?
            let totalTime: Int?
            let image: String
            let ingredientLines: [String]
            let url: String
        }
        
        struct WelcomeLinks: Decodable {
            let next: Next
        }
        struct Next: Decodable {
            let href: String
        }
    }

}

