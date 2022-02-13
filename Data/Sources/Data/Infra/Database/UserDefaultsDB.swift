//
//  UserDefaultsDB.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation

public class UserDefaultsDB {
    
    public static let shared: UserDefaultsDB = UserDefaultsDB()
    
    private init() {}
}

// MARK: Database Interface
extension UserDefaultsDB: Database {
    public func all<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements = UserDefaults.standard.array(forKey: tableKey) as? [EntityType]
        return elements ?? []
    }
    
    public func get<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let elements: [EntityType] = all()
        return elements.first(where: { $0.primaryKey == key })
    }
    
    public func remove<EntityType>(key: EntityType.PrimaryKey) -> EntityType? where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        var elements: [EntityType] = all()
        let removedElement = elements.removeFirst(where: { $0.primaryKey == key })
        UserDefaults.standard.set(elements, forKey: tableKey)
        return removedElement
    }
    
    public func add<EntityType>(object: EntityType) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        var elements: [EntityType] = all()
        elements.append(object)
        UserDefaults.standard.set(elements, forKey: tableKey)
    }
    
    public func update<EntityType>(object: EntityType) where EntityType : Entity {
        let _: EntityType? = remove(key: object.primaryKey)
        add(object: object)
    }
    
    public func dropAll<EntityType>() -> [EntityType] where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        let elements: [EntityType] = all()
        UserDefaults.standard.removeObject(forKey: tableKey)
        return elements
    }
    
    public func addArray<EntityType>(objects: [EntityType]) where EntityType : Entity {
        let tableKey = String(describing: EntityType.self)
        UserDefaults.standard.set(objects, forKey: tableKey)
    }
}
