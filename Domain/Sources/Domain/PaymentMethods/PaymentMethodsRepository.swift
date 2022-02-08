//
//  PaymentMethodsRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol PaymentMethodsRepository {
    func fetchPaymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError>
}
