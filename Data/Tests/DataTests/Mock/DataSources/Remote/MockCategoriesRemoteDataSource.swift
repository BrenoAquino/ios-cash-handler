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
            .init(id: 0, name: "Category0"),
            .init(id: 1, name: "Category1"),
            .init(id: 2, name: "Category2")
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
