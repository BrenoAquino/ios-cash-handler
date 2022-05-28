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
        let localDataSource = MockCategoriesLocalDataSource(categories: [])
        let repository = CategoriesRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        var categories: [Domain.Category]?
        
        // When
        repository
            .categories()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                categories = value
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(categories)
        XCTAssertEqual(categories?.count, 3)
        XCTAssertEqual(categories?[0].id, "0")
        XCTAssertEqual(categories?[1].name, "Category1")
        XCTAssertNotNil(localDataSource.updatedCategories)
        XCTAssertEqual(localDataSource.updatedCategories?.count, 3)
        XCTAssertEqual(localDataSource.updatedCategories?[0].primaryKey, "0")
        XCTAssertEqual(localDataSource.updatedCategories?[1].name, "Category1")
    }
    
    func testCategoriesWithLocalContent() {
        // Given
        let expectation = expectation(description: "success fetch from cache")
        let remoteDataSource = MockErrorCategoriesRemoteDataSource()
        let localDataSource = MockCategoriesLocalDataSource()
        let repository = CategoriesRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        var categories: [Domain.Category]?
        
        // When
        repository
            .categories()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                categories = value
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(categories?.count, 2)
    }
    
    func testFetchCategoriesErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch categories")
        let repository = CategoriesRepositoryImpl(remoteDataSource: MockErrorCategoriesRemoteDataSource(),
                                                  localDataSource: MockCategoriesLocalDataSource(categories: []))
        var error: Domain.CharlesError?
        
        // When
        repository
            .categories()
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
        XCTAssertEqual(error?.type, .networkError)
    }
}
