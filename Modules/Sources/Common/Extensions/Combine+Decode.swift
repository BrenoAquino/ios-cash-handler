//
//  Combine+Decode.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation
import Combine

extension Publisher where Output == Data {
    
    typealias PublisherTryMap = Publishers.TryMap<Self, Self.Output>
    
    public func decode<Item, Coder>(type: Item.Type, decoder: Coder, atKeyPath keyPath: String?) -> Publishers.Decode<Publishers.TryMap<Self, Self.Output>, Item, Coder> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == Coder.Input {
        return tryMap { value in
            if let keyPath = keyPath {
                var json = (try? JSONSerialization.jsonObject(with: value, options: []) as? [String: Any]) ?? [:]
                let keys = keyPath.components(separatedBy: ".")
                
                for key in keys {
                    guard let nestedJson = json[key] as? [String: Any] else {
                        throw NSError()
                    }
                    json = nestedJson
                }
                
                guard let nestedJson = try? JSONSerialization.data(withJSONObject: json, options: []) as? Output else {
                    throw NSError()
                }
                
                return nestedJson
            }
            return value
        }
        .decode(type: type, decoder: decoder)
    }
}
