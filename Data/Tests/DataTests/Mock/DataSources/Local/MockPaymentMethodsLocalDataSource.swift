//
//  MockPaymentMethodsLocalDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation

@testable import Data

class MockPaymentMethodsLocalDataSource: PaymentMethodsLocalDataSource {
    
    let paymentMethodsEntity: [PaymentMethodEntity]
    
    init(paymentMethods: [PaymentMethodEntity]? = nil) {
        self.paymentMethodsEntity = paymentMethods ?? [
            .init(primaryKey: 0, name: "PaymentMethod0"),
            .init(primaryKey: 1, name: "PaymentMethod1")
        ]
    }
    
    func paymentMethods() -> [PaymentMethodEntity] {
        return paymentMethodsEntity
    }
}
