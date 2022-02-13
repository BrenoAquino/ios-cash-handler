//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

public protocol OperationsRepository {
    func addOperation(title: String,
                      date: String,
                      value: Double,
                      categoryId: Int,
                      paymentMethodId: Int) -> AnyPublisher<Operation, CharlesError>
}
