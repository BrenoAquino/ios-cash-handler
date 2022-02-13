//
//  Database.swift
//  
//
//  Created by Breno Aquino on 10/02/22.
//

import Foundation

public protocol Database {
    func all<EntityType>() -> [EntityType] where EntityType : Entity
    
    func get<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity
    func remove<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity
    
    func add<EntityType>(object: EntityType) where EntityType : Entity
    func update<EntityType>(object: EntityType) where EntityType : Entity
    
    func dropAll<EntityType>() -> [EntityType] where EntityType : Entity
    func addArray<EntityType>(objects: [EntityType]) where EntityType : Entity
}
