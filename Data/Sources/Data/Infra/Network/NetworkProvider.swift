//
//  NetworkProvider.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain
import Common

public protocol NetworkProvider {
    func execute<Model: Decodable>(endpoint: APIs, keyPath: String?) -> AnyPublisher<Model, CharlesDataError>
}
