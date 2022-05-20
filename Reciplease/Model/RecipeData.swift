//
//  RecipeData.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

struct RecipeData: Decodable {
    let hits: [Hit]
    
    
    struct WelcomeLinks: Decodable {
        let next: Next?
    }
    
    struct Next: Decodable {
        let href: String?
    }
    
    struct Hit: Decodable {
        let recipe: Recipe
        let links: WelcomeLinks?
        
        enum CodingKeys: String, CodingKey {
            case recipe
            case links = "_links"
        }
        
        struct Recipe: Decodable {
            let label: String
            let yield: Int?
            let totalTime: Int?
            let image: String
            let ingredientLines: [String]
            let url: String
        }
    }

}

