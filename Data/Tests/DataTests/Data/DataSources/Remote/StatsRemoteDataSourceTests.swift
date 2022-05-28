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
                print(completion)
                expectation.fulfill()
            } receiveValue: { value in
                stats = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(stats)
        XCTAssertEqual(stats?.month, "2022-04")
        XCTAssertEqual(stats?.expense, 4687.28)
        XCTAssertEqual(stats?.count, 2)
        XCTAssertEqual(stats?.categories.count, 1)
        XCTAssertEqual(stats?.categories[0].categoryId, "521bac2c00686155bc874aac9c83650c2201140d13c14db953251b635bcc25cb")
        XCTAssertEqual(stats?.categories[0].expense, 4687.28)
        XCTAssertEqual(stats?.categories[0].averageExpense, 1690.56)
        XCTAssertEqual(stats?.categories[0].percentageExpense, 1.0)
        XCTAssertEqual(stats?.categories[0].count, 2)
        XCTAssertEqual(stats?.categories[0].averageCount, 1.67)
        XCTAssertEqual(stats?.categories[0].percentageCount, 1.0)
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
        XCTAssertEqual(monthsStats?.count, 5)
        XCTAssertEqual(monthsStats?[0].month, "2022-01")
        XCTAssertEqual(monthsStats?[0].expense, 130.79)
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
