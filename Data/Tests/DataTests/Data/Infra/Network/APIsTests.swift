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
    case queryParams
}

extension APIsMock: APIs {
    var baseURL: String {
        switch self {
        case .get, .post, .delete, .put, .validUrl, .queryParams:
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
        case .get, .validUrl, .invalidUrl, .queryParams:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .put:
            return .put
        }
    }
    
    var queryParams: [String : Any]? {
        switch self {
        case .queryParams:
            return ["key1": "value1", "key2": 2]
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .post:
            return Data()
        case .get, .delete, .put, .validUrl, .invalidUrl, .queryParams:
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
    
    func testQueryParams() {
        // Given
        let api = APIsMock.queryParams
        
        // When
        let request = try? api.createRequest()
        
        // Then
        var queryParams: [String: String] = [:]
        let queryComponents = request!.url!.query!.components(separatedBy: "&")
        for component in queryComponents {
            let keyValue = component.components(separatedBy: "=")
            queryParams[keyValue[0]] = keyValue[1]
        }
        let url = request!.url!.absoluteString.components(separatedBy: "?")[0]
        
        XCTAssert(url == "https://mock.com/path/to/be/here")
        XCTAssert(queryParams["key1"] == "value1")
        XCTAssert(queryParams["key2"] == "2")
    }
}
