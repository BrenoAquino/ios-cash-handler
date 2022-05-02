//
//  MockCategoriesRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Combine

@testable import Data

class MockSuccessCategoriesRemoteDataSource: CategoriesRemoteDataSource {
    
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        let categories: [CategoryDTO] = [
            .init(id: "0", name: "Category0"),
            .init(id: "1", name: "Category1"),
            .init(id: "2", name: "Category2")
        ]
        return Just(categories)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}

class MockErrorCategoriesRemoteDataSource: CategoriesRemoteDataSource {
    
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}

class MockCounterCategoriesRemoteDataSource: CategoriesRemoteDataSource {
    
    private(set) var categoriesCallsCount: Int = .zero
    private let delay: TimeInterval
    
    init(responseDelay: TimeInterval) {
        self.delay = responseDelay
    }
    
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        categoriesCallsCount += 1
        let categories: [CategoryDTO] = [
            .init(id: "0", name: "Category0"),
            .init(id: "1", name: "Category1"),
            .init(id: "2", name: "Category2")
        ]
        return Just(categories)
            .delay(for: .seconds(delay), scheduler: RunLoop.main, options: .none)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}

class MockDelayCategoriesRemoteDataSource: CategoriesRemoteDataSource {
    
    private(set) var categoriesCallsCount: Int = .zero
    private let delay: TimeInterval
    
    init(responseDelay: TimeInterval) {
        self.delay = responseDelay
    }
    
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        let categories: [CategoryDTO] = [
            .init(id: "\(categoriesCallsCount + 0)", name: "Category\(categoriesCallsCount + 0)"),
            .init(id: "\(categoriesCallsCount + 1)", name: "Category\(categoriesCallsCount + 1)"),
            .init(id: "\(categoriesCallsCount + 2)", name: "Category\(categoriesCallsCount + 2)")
        ]
        categoriesCallsCount += 3
        return Just(categories)
            .delay(for: .seconds(delay), scheduler: RunLoop.main, options: .none)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}
