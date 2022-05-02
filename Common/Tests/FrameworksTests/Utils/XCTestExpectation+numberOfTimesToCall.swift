//
//  XCTestExpectation+numberOfTimesToCall.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import XCTest

extension XCTestExpectation {
    @discardableResult
    func numberOfTimesToCall(_ count: Int) -> Self {
        expectedFulfillmentCount = count
        return self
    }
}
