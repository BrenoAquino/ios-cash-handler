//
//  CategoriesRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Common

public protocol CategoriesRepository {
    func categories() -> AnyDataPubliher<[Category], CharlesError>
}
