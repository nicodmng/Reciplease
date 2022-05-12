//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import Alamofire

// MARK: - Protocol

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void)
}

final class RecipeSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void) {
        AF.request(url).responseDecodable(of: RecipeData.self) { response in
            callback(response)
        }
    }
}
