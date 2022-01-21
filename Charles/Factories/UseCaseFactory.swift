//
//  UseCaseFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Domain

enum UseCaseFactory {
    
    static func operations() -> OperationsUseCase {
        let repository = RepositoryFactory.operations()
        return OperationsUseCaseImpl(operationsRepository: repository)
    }
}
