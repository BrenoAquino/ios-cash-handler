//
//  File.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
public class CategoriesUseCasePreview: CategoriesUseCase {
    private let categoriesArray: [Domain.Category] = [
        Domain.Category(id: "0", name: "Lazer"),
        Domain.Category(id: "1", name: "Tecnologia")
    ]
    
    public init() {}
    
    public func cachedCategories() -> [Domain.Category] {
        categoriesArray
    }
    
    public func categories() -> AnyPublisher<[Domain.Category], CharlesError> {
        return Just(categoriesArray)
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
}
#endif
