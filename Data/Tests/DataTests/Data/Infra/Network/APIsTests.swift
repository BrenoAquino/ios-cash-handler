//
//  APIsTests.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import XCTest

@testable import Data

enum APIsMock {
    case get
    case post
    case delete
    case put
    case validUrl
    case invalidUrl
}

extension APIsMock: APIs {
    var baseURL: String {
        switch self {
        case .get, .post, .delete, .put, .validUrl:
            return "https://mock.com"
        case .invalidUrl:
            return "ç"
        }
    }
    
    var path: String {
        "path/to/be/here"
    }
    
    var method: RequestMethod {
        switch self {
        case .get, .validUrl, .invalidUrl:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .put:
            return .put
        }
    }
    
    var body: Data? {
        switch self {
        case .post:
            return Data()
        case .get, .delete, .put, .validUrl, .invalidUrl:
            return nil
        }
    }
}

class APIsTests: XCTestCase {
    
    func testRequestGet() {
        // Given
        let api = APIsMock.get
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssert(request?.httpMethod == "GET")
    }
    
    func testRequestPost() {
        // Given
        let api = APIsMock.post
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssert(request?.httpMethod == "POST")
    }
    
    func testRequestDelete() {
        // Given
        let api = APIsMock.delete
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssert(request?.httpMethod == "DELETE")
    }
    
    func testRequestPut() {
        // Given
        let api = APIsMock.put
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssert(request?.httpMethod == "PUT")
    }
    
    func testCreateRequestWithBody() {
        // Given
        let api = APIsMock.post
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssertNotNil(request?.httpBody)
    }
    
    func testCreateRequestWithoutBody() {
        // Given
        let api = APIsMock.get
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssertNil(request?.httpBody)
    }
    
    func testValidURL() {
        // Given
        let api = APIsMock.validUrl
        
        // When
        let request = try? api.createRequest()
        
        // Then
        XCTAssert(request?.url?.absoluteString == "https://mock.com/path/to/be/here")
    }
    
    func testInvalidURL() {
        // Given
        var error: CharlesDataError?
        let api = APIsMock.invalidUrl
        
        // When
        do {
            _ = try api.createRequest()
        } catch let err {
            error = err as? CharlesDataError
        }
        
        // Then
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidURL)
    }
}
