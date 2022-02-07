//
//  Network.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain
import Common

protocol Network {
    associatedtype Endpoints: APIs
    
    var session: URLSession { get }
    var queue: DispatchQueue { get }
}

extension Network {
    func execute<Model: Decodable>(endpoint: Endpoints) -> AnyPublisher<Model, CharlesError> {
        do {
            let request = try endpoint.createRequest()
            return execute(session: session, request: request)
        } catch let error {
            switch error {
            case let error as CharlesError:
                return Fail<Model, CharlesError>(error: error).eraseToAnyPublisher()
            default:
                return Fail<Model, CharlesError>(error: CharlesError(type: .unkown)).eraseToAnyPublisher()
            }
        }
    }
    
    private func execute<Model: Decodable>(session: URLSession, request: URLRequest) -> AnyPublisher<Model, CharlesError> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw CharlesError(type: .invalidResponse)
                }
                
                guard response.statusCode >= 200 && response.statusCode <= 299 else {
                    throw CharlesError(networkCode: response.statusCode)
                }
                
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder(), atKeyPath: "data")
            .mapError { error in
                switch error {
                case _ as DecodingError:
                    return CharlesError(type: .invalidDecoding)
                case let error as URLError:
                    return CharlesError(networkCode: error.errorCode)
                default:
                    return CharlesError(type: .unkown)
                }
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
