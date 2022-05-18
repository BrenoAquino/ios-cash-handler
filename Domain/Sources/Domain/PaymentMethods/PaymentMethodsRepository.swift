//
//  PaymentMethodsRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Common

public protocol PaymentMethodsRepository {
    func paymentMethods() -> AnyDataPubliher<[PaymentMethod], CharlesError>
}
