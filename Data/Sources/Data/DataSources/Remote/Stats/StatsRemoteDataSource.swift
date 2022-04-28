//
//  StatsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Combine

public protocol StatsRemoteDataSource {
    func stats(params: StatsParams) -> AnyPublisher<StatsDTO, CharlesDataError>
    func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStatsDTO], CharlesDataError>
}

// MARK: Implementation
public final class StatsRemoteDataSourceImpl {
    typealias Endpoints = StatsAPIs
    
    let networkProvider: NetworkProvider
    
    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
}

// MARK: Requests
extension StatsRemoteDataSourceImpl: StatsRemoteDataSource {
    public func stats(params: StatsParams) -> AnyPublisher<StatsDTO, CharlesDataError> {
        return networkProvider.execute(endpoint: Endpoints.stats(params: params), keyPath: "data")
    }
    
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStatsDTO], CharlesDataError> {
        return networkProvider.execute(endpoint: Endpoints.historic(numberOfMonths: numberOfMonths), keyPath: "data")
    }
}
