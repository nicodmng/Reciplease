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
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

final class RecipeSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { response in
            callback(response)
        }
    }
}
