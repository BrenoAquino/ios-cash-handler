//
//  CharlesDataErrorTests.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import XCTest

@testable import Data

class CharlesDataErrorTests: XCTestCase {
    
    // MARK: Init
    func testInitWithType() {
        // Given
        let type = CharlesDataError.ErrorType.invalidDecoding
        
        // When
        let error = CharlesDataError(type: type)
        
        // Then
        XCTAssert(error.type == .invalidDecoding)
    }
    
    func testInitWithCode() {
        // Given
        let badRequestType = CharlesDataError.ErrorType.badRequest
        
        // When
        let errorBadRequest = CharlesDataError(code: badRequestType.rawValue)
        
        // Then
        XCTAssert(errorBadRequest.type == .badRequest)
    }
    
    func testInitWithInvalidCode() {
        // Given
        let invalidCode = Int.min
        
        // When
        let errorBadRequest = CharlesDataError(code: invalidCode)
        
        // Then
        XCTAssert(errorBadRequest.type == .unkown)
    }
    
    func testToDomainUnknow() {
        // Given
        let error = CharlesDataError(type: .unkown)
        
        // When
        let errorDomain = error.toDomain()
        
        // Then
        XCTAssert(errorDomain.type == .unkown)
    }
    
    func testToDomain() {
        // Given
        let error = CharlesDataError(type: .badRequest)
        
        // When
        let errorDomain = error.toDomain()
        
        // Then
        XCTAssert(errorDomain.type == .networkError)
    }
}
