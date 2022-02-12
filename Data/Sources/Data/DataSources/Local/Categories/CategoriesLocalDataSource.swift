//
//  CategoriesLocalDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Combine

public protocol CategoriesLocalDataSource {
    func categories() -> [CategoryEntity]
}

public final class CategoriesLocalDataSourceImpl {
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
}

// MARK: Requests
extension CategoriesLocalDataSourceImpl: CategoriesLocalDataSource {
    public func categories() -> [CategoryEntity] {
        return database.all()
    }
}
