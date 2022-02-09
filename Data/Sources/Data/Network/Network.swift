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
    func execute<Model: Decodable>(endpoint: Endpoints, keyPath: String? = nil) -> AnyPublisher<Model, CharlesDataError> {
        do {
            let request = try endpoint.createRequest()
            return execute(session: session, request: request, keyPath: keyPath)
        } catch let error {
            switch error {
            case let error as CharlesDataError:
                return Fail<Model, CharlesDataError>(error: error)
                    .eraseToAnyPublisher()
            default:
                return Fail<Model, CharlesDataError>(error: CharlesDataError(type: .unkown))
                    .eraseToAnyPublisher()
            }
        }
    }
    
    private func execute<Model: Decodable>(session: URLSession, request: URLRequest, keyPath: String? = nil) -> AnyPublisher<Model, CharlesDataError> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw CharlesDataError(type: .invalidResponse)
                }
                guard response.statusCode >= 200 && response.statusCode <= 299 else {
                    throw CharlesDataError(networkCode: response.statusCode)
                }
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder(), atKeyPath: keyPath)
            .mapError { error in
                switch error {
                case _ as DecodingError:
                    return CharlesDataError(type: .invalidDecoding)
                case let error as URLError:
                    return CharlesDataError(networkCode: error.errorCode)
                default:
                    return CharlesDataError(type: .unkown)
                }
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
