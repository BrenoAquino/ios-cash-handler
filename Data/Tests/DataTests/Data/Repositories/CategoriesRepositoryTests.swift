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
        let localDataSource = MockCategoriesLocalDataSource()
        let repository = CategoriesRepositoryImpl(remoteDataSource: MockSuccessCategoriesRemoteDataSource(),
                                                  localDataSource: localDataSource)
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
        XCTAssertNotNil(localDataSource.updatedCategories)
        XCTAssert(localDataSource.updatedCategories?.count == 3)
        XCTAssert(localDataSource.updatedCategories?[0].primaryKey == 0)
        XCTAssert(localDataSource.updatedCategories?[1].name == "Category1")
    }
    
    func testFetchCategoriesErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch categories")
        let repository = CategoriesRepositoryImpl(remoteDataSource: MockErrorCategoriesRemoteDataSource(),
                                                  localDataSource: MockCategoriesLocalDataSource())
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
    
    // MARK: Cached Categories
    func testCachedCategoroes() {
        // Given
        let repository = CategoriesRepositoryImpl(remoteDataSource: MockSuccessCategoriesRemoteDataSource(),
                                                  localDataSource: MockCategoriesLocalDataSource())
        
        // When
        let categories = repository.cachedCategories()
        
        // Then
        XCTAssert(categories.count == 2)
        XCTAssert(categories[0].id == 0)
        XCTAssert(categories[1].name == "Category1")
    }
}
