//
//  PaymentMethodsLocalDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import XCTest

@testable import Data

class PaymentMethodsLocalDataSourceTests: XCTestCase {
    
    // MARK: Payment Methods
    func testPaymentMethods() {
        // Give
        let tableKey = String(describing: PaymentMethodEntity.self)
        let database = MockDatabase(tables: [tableKey: [
            PaymentMethodEntity(primaryKey: "0", name: "PaymentMethod0"),
            PaymentMethodEntity(primaryKey: "1", name: "PaymentMethod1")
        ]])
        let localDataSource = PaymentMethodsLocalDataSourceImpl(database: database)
        
        // When
        let paymentMethods = localDataSource.paymentMethods()
        
        // Then
        XCTAssert(paymentMethods.count == 2)
        XCTAssert(paymentMethods[0].primaryKey == "0")
        XCTAssert(paymentMethods[1].name == "PaymentMethod1")
    }
    
    // MARK: Update Payment Methods
    func testUpdatePaymentMethods() {
        // Give
        let tableKey = String(describing: PaymentMethodEntity.self)
        let database = MockDatabase(tables: [tableKey: [
            PaymentMethodEntity(primaryKey: "0", name: "PaymentMethod0"),
            PaymentMethodEntity(primaryKey: "1", name: "PaymentMethod1")
        ]])
        let localDataSource = PaymentMethodsLocalDataSourceImpl(database: database)
        
        // When
        localDataSource.updatePaumentMethods([
            .init(primaryKey: "2", name: "PaymentMethod2"),
            .init(primaryKey: "3", name: "PaymentMethod3")
        ])
        
        // Then
        let paymentMethods = database.tables[tableKey] as? [PaymentMethodEntity]
        XCTAssertNotNil(paymentMethods)
        XCTAssert(paymentMethods?.count == 2)
        XCTAssert(paymentMethods?[0].primaryKey == "2")
        XCTAssert(paymentMethods?[1].name == "PaymentMethod3")
    }
}
