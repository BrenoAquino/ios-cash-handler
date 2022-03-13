//
//  File.swift
//  
//
//  Created by Breno Aquino on 13/03/22.
//

import Foundation

public extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
            throw NSError()
        }
        return dictionary
    }
}
