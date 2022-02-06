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
