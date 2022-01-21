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
                      category: String,
                      paymentType: String,
                      operationType: String) -> AnyPublisher<Operation, Error>
}
