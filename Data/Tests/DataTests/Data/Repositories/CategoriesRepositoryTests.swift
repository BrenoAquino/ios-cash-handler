//
//  CategoriesRepositoryTests.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Combine
import Domain

@testable import Data

class CategoriesRepositoryTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Fetch Categories
    func testFetchCategoriesSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch categories")
        let remoteDataSource = MockSuccessCategoriesRemoteDataSource()
        let repository = CategoriesRepositoryImpl(remoteDataSource: remoteDataSource)
        var categories: [Domain.Category]?
        
        // When
        repository
            .fetchCategories()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                categories = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(categories)
        XCTAssert(categories?.count == 3)
        XCTAssert(categories?[0].id == 0)
        XCTAssert(categories?[1].name == "Category1")
    }
    
    func testFetchCategoriesErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch categories")
        let remoteDataSource = MockErrorCategoriesRemoteDataSource()
        let repository = CategoriesRepositoryImpl(remoteDataSource: remoteDataSource)
        var error: Domain.CharlesError?
        
        // When
        repository
            .fetchCategories()
            .sinkCompletion { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .networkError)
    }
}
