//
//  Mock.swift
//  Charles
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Domain

class CategoryRepoMock: Domain.CategoriesRepository {
    func fetchCategories() -> AnyPublisher<[Domain.Category], Domain.CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
}

class PaymenteRepoMock: Domain.PaymentMethodsRepository {
    func fetchPaymentMethods() -> AnyPublisher<[Domain.PaymentMethod], Domain.CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
}
