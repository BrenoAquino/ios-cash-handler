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
        XCTAssert(networkProvider.api?.hashValue() == StatsAPIs.stats(params: .init(month: 4, year: 2022)).hashValue())
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
        XCTAssert(stats?.month == 4)
        XCTAssert(stats?.year == 2022)
        XCTAssert(stats?.expense == 732.14)
        XCTAssert(stats?.categories.count == 3)
        XCTAssert(stats?.categories[0].categoryId == "d738b05e792cf0108226b0f8a128e0a9203b859ab55c66fce4a4f480463ea328")
        XCTAssert(stats?.categories[0].expense == 192.14)
        XCTAssert(stats?.categories[0].averageExpense == 4725)
        XCTAssert(stats?.categories[0].count == 1)
        XCTAssert(stats?.categories[0].averageCount == 8)
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
        let expectation = expectation(description: "historic")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        remoteDataSource
            .historic(numberOfMonths: 4)
            .sinkCompletion { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [MonthStatsDTO].self)
        XCTAssert(networkProvider.api?.hashValue() == StatsAPIs.historic(numberOfMonths: 4).hashValue())
    }
    
    func testHistoricDecoding() {
        // Given
        let expectation = expectation(description: "decoding historic")
        let networkProvider = DecoderMockNetworkProvider(file: .historicSuccess)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var monthsStats: [MonthStatsDTO]?

        // When
        remoteDataSource
            .historic(numberOfMonths: 4)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                monthsStats = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(monthsStats)
        XCTAssert(monthsStats?.count == 2)
        XCTAssert(monthsStats?[0].month == 4)
        XCTAssert(monthsStats?[0].year == 2022)
        XCTAssert(monthsStats?[0].expense == 732.14)
    }

    func testHistoricDecodingError() {
        // Given
        let expectation = expectation(description: "dencoding error historic")
        let networkProvider = DecoderMockNetworkProvider(file: .historicDecodingError)
        let remoteDataSource = StatsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
            .historic(numberOfMonths: 4)
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
}
