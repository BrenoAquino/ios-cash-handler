//
//  Combine+Decode.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation
import Combine

extension Publisher where Output == Data {
    
    public func decode<Item, Coder>(type: Item.Type, decoder: Coder, atKeyPath keyPath: String?) -> Publishers.Decode<Publishers.TryMap<Self, Self.Output>, Item, Coder> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == Coder.Input {
        return tryMap { value in
            if let keyPath = keyPath {
                let json = try? JSONSerialization.jsonObject(with: value, options: []) as? NSDictionary
                
                if let result = json?.value(forKeyPath: keyPath), let nestedJson = try? JSONSerialization.data(withJSONObject: result) {
                    return nestedJson
                }
            }
            return value
        }
        .decode(type: type, decoder: decoder)
    }
}
