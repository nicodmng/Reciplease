//
//  FakeRecipeSession.swift
//  RecipleaseTests
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeResponse {
    var response: HTTPURLResponse? 
    var data: Data?
}

final class FakeRecipeSession: AlamofireSession {
    
    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods

    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void) {
        let result = RecipeData(hits: [])
        let dataResponse = AFDataResponse<RecipeData>(request: URLRequest(url: url), response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0.0, result: .success(result))
        callback(dataResponse)
    }
}
