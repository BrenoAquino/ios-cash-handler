//
//  CategoriesUseCase.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Common

public protocol CategoriesUseCase {
    func categories() -> AnyDataPubliher<[Category], CharlesError>
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
    public func categories() -> AnyDataPubliher<[Category], CharlesError> {
        return categoriesRepository
            .categories()
            .mapDataResult { $0.sorted(by: { $0.name < $1.name }) }
            .eraseToAnyPublisher()
    }
}
