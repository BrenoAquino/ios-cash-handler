//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

public protocol OperationsRepository {
    func operations(categories: [Domain.Category], paymentMethods: [Domain.PaymentMethod]) -> AnyPublisher<[Domain.Operation], CharlesError>
    func addOperation(createOperation: CreateOperation,
                      categories: [Domain.Category],
                      paymentMethods: [Domain.PaymentMethod]) -> AnyPublisher<[Domain.Operation], CharlesError>
}
