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
    
    static func categories() -> CategoriesUseCase {
        return CategoriesUseCaseImpl(categoriesRepository: RepositoryFactory.categories())
    }
    
    static func paymentMethods() -> PaymentMethodsUseCase {
        return PaymentMethodsUseCaseImpl(paymentMethodsRepository: RepositoryFactory.paymentMethods())
    }
    
    static func stats() -> StatsUseCase {
        return StatsUseCaseImpl(statsRepository: RepositoryFactory.stats(),
                                categoriesRepository: RepositoryFactory._categories())
    }
}
