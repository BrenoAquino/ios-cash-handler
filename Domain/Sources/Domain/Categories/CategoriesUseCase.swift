//
//  CategoriesUseCase.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol CategoriesUseCase {
    func categories() -> AnyPublisher<[Category], CharlesError>
    func cachedCategories() -> [Category]
}

// MARK: Implementation
public final class CategoriesUseCaseImpl {
    
    private let categoriesRepository: CategoriesRepository
    
    public init(categoriesRepository: CategoriesRepository) {
        self.categoriesRepository = categoriesRepository
    }
}

// MARK: Interfaces
extension CategoriesUseCaseImpl: CategoriesUseCase {
    public func cachedCategories() -> [Category] {
        return categoriesRepository
            .cachedCategories()
    }
    
    public func categories() -> AnyPublisher<[Category], CharlesError> {
        return categoriesRepository
            .fetchCategories()
            .map { $0.sorted(by: { $0.name < $1.name }) }
            .eraseToAnyPublisher()
    }
}
