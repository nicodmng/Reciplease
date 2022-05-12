//
//  RecipeService.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

final class RecipeService {
    
    // MARK: - Properties
    
    let session: AlamofireSession
    
    // MARK: - Initializer
    
    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }
    
    // MARK: - Methods
    
    func getRecipe(ingredients: [String], callback: @escaping (Result<RecipeData, NetworkError>) -> Void) {
        var components = URLComponents(string: "")!
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/api/recipes/v2"
        components.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: "dde6421f"),
            URLQueryItem(name: "app_key", value: "046769644acb80f3d20a31450e827f43"),
            URLQueryItem(name: "q", value: ingredients.joined(separator: ","))
        ]
        guard let url = components.url else { return }
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.value else {
                callback(.failure(.noData))
                return
            }
            callback(.success(data))
        }
    }
}
