//
//  URLSessionNetwork.swift
//  
//
//  Created by Breno Aquino on 10/02/22.
//

import Foundation
import Combine

public class URLSessionNetwork {
    
    let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private func execute<Model: Decodable>(session: URLSession, request: URLRequest, keyPath: String? = nil) -> AnyPublisher<Model, CharlesDataError> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw CharlesDataError(type: .invalidResponse)
                }
                guard response.statusCode >= 200 && response.statusCode <= 299 else {
                    throw CharlesDataError(code: response.statusCode)
                }
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder(), atKeyPath: keyPath)
            .mapError { error in
                switch error {
                case _ as DecodingError:
                    return CharlesDataError(type: .invalidDecoding)
                case let error as URLError:
                    return CharlesDataError(code: error.errorCode)
                default:
                    return CharlesDataError(type: .unkown)
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: Interface
extension URLSessionNetwork: NetworkProvider {
    public func execute<Model: Decodable>(endpoint: APIs, keyPath: String? = nil) -> AnyPublisher<Model, CharlesDataError> {
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
}
