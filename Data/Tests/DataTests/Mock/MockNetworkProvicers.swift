//
//  MockNetworkProvicers.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation
import Combine

@testable import Data

extension APIs {
    func hashValue() -> Int {
        var hash = Hasher()
        hash.combine(baseURL)
        hash.combine(path)
        hash.combine(method.rawValue)
        if let body = body {
            hash.combine(body)
        }
        return hash.finalize()
    }
}

class TypeMockNetworkProvider: NetworkProvider {
    
    var decodableType: Decodable.Type?
    var api: APIs?
    
    func execute<Model: Decodable>(endpoint: APIs, keyPath: String?) -> AnyPublisher<Model, CharlesDataError> {
        decodableType = Model.self
        api = endpoint
        return Empty().eraseToAnyPublisher()
    }
}

class DecoderMockNetworkProvider: NetworkProvider {
    
    let file: MockFile
    
    init(file: MockFile) {
        self.file = file
    }
    
    func execute<Model: Decodable>(endpoint: APIs, keyPath: String?) -> AnyPublisher<Model, CharlesDataError> {
        Just(file.data)
            .decode(type: Model.self, decoder: JSONDecoder(), atKeyPath: keyPath)
            .mapError { error in
                switch error {
                case _ as DecodingError:
                    return CharlesDataError(type: .invalidDecoding)
                default:
                    return CharlesDataError(type: .unkown)
                }
            }
            .eraseToAnyPublisher()
    }
}
