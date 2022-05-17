//
//  RequestServiceTests.swift
//  RecipleaseTests
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

import XCTest
import Alamofire
@testable import Reciplease

class RequestServiceTests: XCTestCase {

    let ingredient = "chocolate"
    
    func testGetRecipe_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        sut.getRecipe(ingredients: [ingredient]) { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
//        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
//        let sut = RecipeService(session: session)
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        
//        sut.getRecipe(ingredients: [ingredient]) { result in
//            
//            guard case .failure(let error) = result else {
//                XCTFail("Test getData method with incorrect response failed.")
//                return
//            }
//            XCTAssertNotNil(error)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
    
    
//    func testGetRecipe_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
//        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
//        let sut = RecipeService(session: session)
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.getRecipe(ingredients: [ingredient]) { result in
//            guard case .success(let data) = result else {
//                XCTFail("Test getRecipe method with correct data failed.")
//                return
//            }
//            XCTAssertTrue(data.hits[0].recipe.label == "Chocolate Covered Chocolates Recipe")
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
}
