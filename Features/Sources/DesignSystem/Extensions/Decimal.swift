//
//  File.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import Foundation

public extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

public extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

public extension LosslessStringConvertible {
    var string: String { .init(self) }
}
