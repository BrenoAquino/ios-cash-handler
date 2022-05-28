//
//  CategoriesLocalDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import XCTest

@testable import Data

class CategoriesLocalDataSourceTests: XCTestCase {
    
    // MARK: Categories
    func testCategories() {
        // Give
        let tableKey = String(describing: CategoryEntity.self)
        let database = MockDatabase(tables: [tableKey: [
            CategoryEntity(primaryKey: "0", name: "Category0"),
            CategoryEntity(primaryKey: "1", name: "Category1")
        ]])
        let localDataSource = CategoriesLocalDataSourceImpl(database: database)
        
        // When
        let categories = localDataSource.categories()
        
        // Then
        XCTAssertEqual(categories.count, 2)
        XCTAssertEqual(categories[0].primaryKey, "0")
        XCTAssertEqual(categories[1].name, "Category1")
    }
    
    // MARK: Update Categories
    func testUpdateCategories() {
        // Give
        let tableKey = String(describing: CategoryEntity.self)
        let database = MockDatabase(tables: [tableKey: [
            CategoryEntity(primaryKey: "0", name: "Category0"),
            CategoryEntity(primaryKey: "1", name: "Category1")
        ]])
        let localDataSource = CategoriesLocalDataSourceImpl(database: database)
        
        // When
        localDataSource.updateCategories([
            .init(primaryKey: "2", name: "Category2"),
            .init(primaryKey: "3", name: "Category3")
        ])
        
        // Then
        let categories = database.tables[tableKey] as? [CategoryEntity]
        XCTAssertNotNil(categories)
        XCTAssertEqual(categories?.count, 2)
        XCTAssertEqual(categories?[0].primaryKey, "2")
        XCTAssertEqual(categories?[1].name, "Category3")
    }
}
