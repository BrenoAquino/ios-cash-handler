//
//  StatsRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import XCTest
import Common
import Combine

@testable import Data

class StatsRemoteDataSourceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Stats
    func testStats() {
        // Given
        let expectation = expectation(description: "stats")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        remoteDataSource
            .stats(params: .init(month: 4, year: 2022))
            .sinkCompletion { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == StatsDTO.self)
        XCTAssertEqual(networkProvider.api?.hashValue(), StatsAPIs.stats(params: .init(month: 4, year: 2022)).hashValue())
    }
    
    func testStatsDecoding() {
        // Given
        let expectation = expectation(description: "decoding stats")
        let networkProvider = DecoderMockNetworkProvider(file: .statsSuccess)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var stats: StatsDTO?

        // When
        remoteDataSource
            .stats(params: .init(month: 4, year: 2022))
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                stats = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(stats)
        XCTAssertEqual(stats?.month, "2022-04")
        XCTAssertEqual(stats?.expense, 732.14)
        XCTAssertEqual(stats?.count, 2)
        XCTAssertEqual(stats?.categories.count, 3)
        XCTAssertEqual(stats?.categories[0].categoryId, "61e5fd461fa16bf63f4493ae6417f52640e0c15998be8a17c963b2483a66e677")
        XCTAssertEqual(stats?.categories[0].expense, 330)
        XCTAssertEqual(stats?.categories[0].averageExpense, 6417)
        XCTAssertEqual(stats?.categories[0].percentageExpense, 0.45)
        XCTAssertEqual(stats?.categories[0].count, 1)
        XCTAssertEqual(stats?.categories[0].averageCount, 5)
    }

    func testStatsDecodingError() {
        // Given
        let expectation = expectation(description: "dencoding error stats")
        let networkProvider = DecoderMockNetworkProvider(file: .statsDecodingError)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
            .stats(params: .init(month: 4, year: 2022))
            .sinkCompletion { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
    
    // MARK: Historic
    func testHistoric() {
        // Given
        let params: HistoricParams = .init(startDate: "2022-01-01", endDate: "2022-05-01")
        let expectation = expectation(description: "historic")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        remoteDataSource
            .historic(params: params)
            .sinkCompletion { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [MonthStatsDTO].self)
        XCTAssertEqual(networkProvider.api?.hashValue(), StatsAPIs.historic(params: params).hashValue())
    }
    
    func testHistoricDecoding() {
        // Given
        let expectation = expectation(description: "decoding historic")
        let networkProvider = DecoderMockNetworkProvider(file: .historicSuccess)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var monthsStats: [MonthStatsDTO]?

        // When
        remoteDataSource
            .historic(params: .init(startDate: "2022-01-01", endDate: "2022-05-01"))
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                monthsStats = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(monthsStats)
        XCTAssertEqual(monthsStats?.count, 2)
        XCTAssertEqual(monthsStats?[0].month, "2022-01")
        XCTAssertEqual(monthsStats?[0].expense, 732.14)
    }

    func testHistoricDecodingError() {
        // Given
        let expectation = expectation(description: "dencoding error historic")
        let networkProvider = DecoderMockNetworkProvider(file: .historicDecodingError)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
            .historic(params: .init(startDate: "2022-01-01", endDate: "2022-05-01"))
            .sinkCompletion { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .invalidDecoding)
    }
}
