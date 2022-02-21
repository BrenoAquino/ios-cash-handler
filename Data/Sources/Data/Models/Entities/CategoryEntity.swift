//
//  CategoryEntity.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Domain

public struct CategoryEntity: Entity {
    public let primaryKey: String
    public let name: String
}

public extension CategoryEntity {
    func toDomain() -> Domain.Category {
        return Domain.Category(id: primaryKey, name: name)
    }
}
