//
//  Network.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

protocol Network {
    associatedtype Endpoints: APIs
    
    var session: URLSession { get }
    var queue: DispatchQueue { get }
}

extension Network {
    func execute<Model: Decodable>(endpoint: Endpoints) -> AnyPublisher<Model, Error> {
        do {
            let request = try endpoint.createRequest()
            return execute(session: session, request: request)
        } catch let error {
            return Fail<Model, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    private func execute<Model: Decodable>(session: URLSession, request: URLRequest) -> AnyPublisher<Model, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap{ data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw CharlesDataError(type: .invalidResponse)
                }
                
                guard response.statusCode >= 200 && response.statusCode <= 299 else {
                    throw CharlesDataError(type: .unsuccessCode(statusCode: response.statusCode))
                }
                
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
