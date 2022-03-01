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
class CategoriesUseCasePreview: CategoriesUseCase {
    func categories() -> AnyPublisher<[Domain.Category], CharlesError> {
        return Just([
            Domain.Category(id: "0", name: "Lazer"),
            Domain.Category(id: "1", name: "Tecnologia")
        ])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
}
#endif
