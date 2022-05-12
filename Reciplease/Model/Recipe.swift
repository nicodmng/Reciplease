//
//  Recipe.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

struct Recipe {
    let labelData: String
    let yieldData: String
    let totalTimeData: String
    let imageData: String
    let ingredientLinesData: [String]
    let urlData: String
    
    init(labelData: String, yieldData: String, totalTimeData: String, imageData: String, ingredientLinesData: [String], urlData: String) {
        self.labelData = labelData
        self.yieldData = yieldData
        self.totalTimeData = totalTimeData
        self.imageData = imageData
        self.ingredientLinesData = ingredientLinesData
        self.urlData = urlData
    }
    
    init(entity: RecipeEntity) {
        self.labelData = entity.label ?? ""
        self.yieldData = entity.yield ?? ""
        self.totalTimeData = entity.time ?? ""
        self.imageData = entity.image ?? ""
        self.ingredientLinesData = entity.ingredientLines ?? []
        self.urlData = entity.url ?? ""
    }
}
