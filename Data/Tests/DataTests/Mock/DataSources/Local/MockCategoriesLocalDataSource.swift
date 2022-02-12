//
//  MockCategoriesLocalDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation

@testable import Data

class MockCategoriesLocalDataSource: CategoriesLocalDataSource {
    
    let categoriesEntity: [CategoryEntity]
    
    init(categories: [CategoryEntity]? = nil) {
        self.categoriesEntity = categories ?? [
            .init(primaryKey: 0, name: "Category0"),
            .init(primaryKey: 1, name: "Category1")
        ]
    }
    
    func categories() -> [CategoryEntity] {
        return categoriesEntity
    }
}
