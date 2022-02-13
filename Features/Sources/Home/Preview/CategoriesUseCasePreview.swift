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
        return Empty().eraseToAnyPublisher()
    }
}
#endif
