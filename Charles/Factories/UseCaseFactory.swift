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
        return OperationsUseCaseImpl(operationsRepository: RepositoryFactory.operations(),
                                     categoriesRepository: RepositoryFactory.categories(),
                                     paymentMethodsRepository: RepositoryFactory.paymentMethods())
    }
}
