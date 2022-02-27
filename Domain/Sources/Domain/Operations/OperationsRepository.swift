//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

public protocol OperationsRepository {
    func operations() -> AnyPublisher<[Operation], CharlesError>
    func addOperation(title: String,
                      date: String,
                      value: Double,
                      categoryId: String,
                      paymentMethodId: String) -> AnyPublisher<Operation, CharlesError>
}
