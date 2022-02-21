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
    
    // MARK: Categories
    func testCategories() {
        // Given
        let expectation = expectation(description: "categories")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = CategoriesRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        _ = remoteDataSource
            .categories()
            .sinkCompletion { _ in
                expectation.fulfill()
            }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [CategoryDTO].self)
        XCTAssert(networkProvider.api?.hashValue() == CategoriesAPIs.categories.hashValue())
    }
    
    func testCategoriesDecoding() {
        // Given
        let expectation = expectation(description: "decoding categories")
        let networkProvider = DecoderMockNetworkProvider(file: .categoriesSuccess)
        let remoteDataSource = CategoriesRemoteDataSourceImpl(networkProvider: networkProvider)
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
        XCTAssert(categories?[0].id == "521bac2c00686155bc874aac9c83650c2201140d13c14db953251b635bcc25cb")
        XCTAssert(categories?[0].name == "Saúde")
    }

    func testCategoriesDecodingError() {
        // Given
        let expectation = expectation(description: "dencoding error categories")
        let networkProvider = DecoderMockNetworkProvider(file: .categoriesDecodingError)
        let remoteDataSource = CategoriesRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
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
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
}
