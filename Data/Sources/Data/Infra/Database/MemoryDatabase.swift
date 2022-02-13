//
//  MemoryDatabase.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation

public class MemoryDatabase {
    
    public static let shared: MemoryDatabase = MemoryDatabase()
    private var tables: [String: [Any]] = [:]
    
    private init() {}
}

// MARK: Database Interface
extension MemoryDatabase: Database {
    
    public func all<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements: [EntityType] = tables[tableKey] as? [EntityType] ?? []
        return elements
    }
    
    public func get<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let elements: [EntityType] = all()
        return elements.first(where: { $0.primaryKey == key })
    }
    
    public func remove<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        var elements: [EntityType] = all()
        let removedElement = elements.removeFirst(where: { $0.primaryKey == key })
        tables[tableKey] = elements
        return removedElement
    }
    
    public func add<EntityType>(object: EntityType) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        tables[tableKey]?.append(object)
    }
    
    public func update<EntityType>(object: EntityType) where EntityType : Entity {
        let _: EntityType? = remove(key: object.primaryKey)
        add(object: object)
    }
    
    public func dropAll<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements: [EntityType] = all()
        tables[tableKey] = []
        return elements
    }
    
    public func addArray<EntityType>(objects: [EntityType]) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        tables[tableKey] = objects
    }
}
