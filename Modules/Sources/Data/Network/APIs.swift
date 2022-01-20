//
//  APIs.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
    case head = "HEAD"
}

protocol APIs {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var body: Data? { get }
}

extension APIs {
    func createRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw CharlesDataError(type: .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
