//
//  CategoriesRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol CategoriesRepository {
    func cachedCategories() -> [Category]
    func fetchCategories() -> AnyPublisher<[Category], CharlesError>
}

public protocol _CategoriesRepository {
    func categories() -> AnyPublisher<[Category], CharlesError>
}
