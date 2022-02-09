//
//  CategoriesRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol CategoriesRemoteDataSource {
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError>
}

public final class CategoriesRemoteDataSourceImpl: Network {
    typealias Endpoints = CategoriesAPIs
    
    var session: URLSession
    var queue: DispatchQueue
    
    public init(session: URLSession, queue: DispatchQueue) {
        self.session = session
        self.queue = queue
    }
}

// MARK: Requests
extension CategoriesRemoteDataSourceImpl: CategoriesRemoteDataSource {
    public func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        return execute(endpoint: .categories, keyPath: "data")
    }
}
