//
//  URLSessionMock.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private var closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

extension URLSessionMock {
    static private func defaultResponse(statusCode: Int) -> HTTPURLResponse? {
        let url = URL(string: "https://google.com.br")!
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    static func success(statusCode: Int = 200, file: MockFile, response: URLResponse? = nil) -> URLSessionMock {
        let sessionMock = URLSessionMock()
        sessionMock.data = file.data
        sessionMock.response = response ?? defaultResponse(statusCode: statusCode)
        return sessionMock
    }
    
    static func failure(statusCode: Int, file: MockFile, error: Error) -> URLSessionMock {
        let sessionMock = URLSessionMock()
        sessionMock.error = error
        return sessionMock
    }
}
