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
            URLQueryItem(name: "q", value: ingredients.joined(separator: ","))]
        
        guard let url = components.url else { return }
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            
            guard let dataDecoded = try? JSONDecoder().decode(RecipeData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
    
//    func nextRecipes(url: String, callback: @escaping (Result<RecipeData, NetworkError>) -> Void) {
//
//        guard let url = URL(string:"https://api.edamam.com/api/recipes/v2?q=chicken&app_key=046769644acb80f3d20a31450e827f43&_cont=CHcVQBtNNQphDmgVQntAEX4BYldtBAUGS2BABWUUZ1xzBgADUXlSUGtFZFV7BwAPEjZGATdAagEiBQFVFWVHCzBCZgd1DAAVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=dde6421f" ) else { return }
//        
//        session.request(url: url) { dataResponse in
//            guard let data = dataResponse.data else {
//                callback(.failure(.noData))
//                return
//            }
//            
//            guard dataResponse.response?.statusCode == 200 else {
//                callback(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let dataDecoded = try? JSONDecoder().decode(RecipeData.self, from: data) else {
//                callback(.failure(.undecodableData))
//                return
//            }
//            callback(.success(dataDecoded))
//        }
//    }
}
// End of Class
