//
//  CategoriesRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Common
import Combine

@testable import Data

class CategoriesRemoteDataSourceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Tests
    func testCategoriesSuccess() {
        // Given
        let expectation = expectation(description: "success categories")
        let sessionMock = URLSessionMock.success(file: .categoriesSuccess)
        let remoteDataSource = CategoriesRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var categories: [CategoryDTO]?
        
        // When
        remoteDataSource
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
        XCTAssert(categories?.count == 9)
        XCTAssert(categories?[0].id == 7)
        XCTAssert(categories?[0].name == "Moradia")
    }
    
    func testAddOperationEcondingError() {
        // Given
        let expectation = expectation(description: "encoding error categories")
        let sessionMock = URLSessionMock.success(file: .categoriesEncodingError)
        let remoteDataSource = CategoriesRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .categories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
    
    func testAddOperationError() {
        // Given
        let expectation = expectation(description: "error add operation")
        let sessionMock = URLSessionMock.failure(statusCode: 500,
                                                 file: .categoriesError,
                                                 error: CharlesDataError(type: .unkown))
        let remoteDataSource = CategoriesRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .categories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .unkown)
    }
}
