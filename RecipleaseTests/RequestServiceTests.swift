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

    // MARK: - Properties
    
    let ingredient = "chocolate"
    let nextPageUrl = "https://api.edamam.com/api/recipes/v2?q=chocolate&app_key=046769644acb80f3d20a31450e827f43&_cont=CHcVQBtNNQphDmgVQntAEX4BYlFtDAEPRmZIB2YXZlR6BAcDUXlSBjcWa1cgDAdTQWYSBjBFMQN1UAMDEWEVA2JHZAEmDVUVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=dde6421f"
    
    // MARK: - Test functions
    
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
    
    func testGetRecipe_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.getRecipe(ingredients: [ingredient]) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
            let sut = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.getRecipe(ingredients: [ingredient]) { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with undecodable data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetRecipe_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.getRecipe(ingredients: []) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.ingredientLines == ["1 cup chocolate morsels (dark, milk, or white)", "16-20 chocolate truffles"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNextRecipes_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        sut.nextRecipes(url: nextPageUrl) { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testNextGetRecipes_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.nextRecipes(url: nextPageUrl) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testNextGetRecipes_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
            let sut = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.nextRecipes(url: nextPageUrl) { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with undecodable data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetNextRecipes_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let sut = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.nextRecipes(url: nextPageUrl) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }
            XCTAssertTrue(data.links?.next.href == "https://api.edamam.com/api/recipes/v2?q=chocolate&app_key=046769644acb80f3d20a31450e827f43&_cont=CHcVQBtNNQphDmgVQntAEX4BYlFtDAEPRmZIB2YXZlR6BAcDUXlSBjcWa1cgDAdTQWYSBjBFMQN1UAMDEWEVA2JHZAEmDVUVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=dde6421f")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
// End of Unit Test
    
