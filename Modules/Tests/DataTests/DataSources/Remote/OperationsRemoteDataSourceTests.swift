//
//  OperationsRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import XCTest
import Common

@testable import Data

class OperationsRemoteDataSourceTests: XCTestCase {
    
    func testAddOperationSuccess() {
        let url = URL(string: "https://google.com.br")!
        let statusCode = 200
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        let sessionMock = URLSessionMock()
        sessionMock.response = response
        sessionMock.data = MockFile.addOperstionSuccess.data
        
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        remoteDataSource
            .addOperation(params: .init(title: .empty, date: .empty, value: .zero, category: .empty, paymentMethod: .empty))
        XCTFail()
    }
    
    func testAddOperationEcondingError() {
        XCTFail()
    }
    
    func testAddOperationError() {
        XCTFail()
    }
}
