//
//  MockDatabase.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation

@testable import Data

class MockDatabase: Database {
    
    var tables: [String: [Any]] = [:]
    
    init(tables: [String: [Any]] = [:]) {
        self.tables = tables
    }
    
    func all<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements: [EntityType] = tables[tableKey] as? [EntityType] ?? []
        return elements
    }
    
    func get<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let elements: [EntityType] = all()
        return elements.first(where: { $0.primaryKey == key })
    }
    
    func remove<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        var elements: [EntityType] = all()
        let removedElement = elements.removeFirst(where: { $0.primaryKey == key })
        tables[tableKey] = elements
        return removedElement
    }
    
    func add<EntityType>(object: EntityType) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        tables[tableKey]?.append(object)
    }
    
    func update<EntityType>(object: EntityType) where EntityType : Entity {
        let _: EntityType? = remove(key: object.primaryKey)
        add(object: object)
    }
    
    func dropAll<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements: [EntityType] = all()
        tables[tableKey] = []
        return elements
    }
    
    func addArray<EntityType>(objects: [EntityType]) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        tables[tableKey] = objects
    }
}
