//
//  PaymentMethodsLocalDatSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Combine

public protocol PaymentMethodsLocalDataSource {
    func paymentMethods() -> [PaymentMethodEntity]
    func updatePaumentMethods(_ paymentMethods: [PaymentMethodEntity])
}

public final class PaymentMethodsLocalDataSourceImpl {
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
}

// MARK: Requests
extension PaymentMethodsLocalDataSourceImpl: PaymentMethodsLocalDataSource {
    public func paymentMethods() -> [PaymentMethodEntity] {
        return database.all()
    }
    
    public func updatePaumentMethods(_ paymentMethods: [PaymentMethodEntity]) {
        let _: [PaymentMethodEntity] = database.dropAll()
        database.addArray(objects: paymentMethods)
    }
}
