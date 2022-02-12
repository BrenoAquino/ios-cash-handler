//
//  File.swift
//  
//
//  Created by Breno Aquino on 10/02/22.
//

import Foundation

public extension Array {
    
    @discardableResult
    mutating func removeFirst(where condition: @escaping (Element) throws -> Bool) -> Element? {
        guard let elemIndex = try? firstIndex(where: condition) else { return nil }
        let elem = self[elemIndex]
        remove(at: elemIndex)
        return elem
    }
}
