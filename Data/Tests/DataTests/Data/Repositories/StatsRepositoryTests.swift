//
//  StatsRepositoryTests.swift
//  
//
//  Created by Breno Aquino on 28/04/22.
//

import XCTest
import Combine
import Domain

@testable import Data

class StatsRepositoryTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Stats
    func testStatsSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch stats")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockSuccessStatsRemoteDataSource(),
                                             categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var stats: Domain.Stats?
        
        // When
        repository
            .stats(month: 4, year: 2022)
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
        XCTAssert(stats?.expense == 234.23)
        XCTAssert(stats?.categories.count == 2)
        XCTAssert(stats?.categories[0].categoryId == "0")
        XCTAssert(stats?.categories[0].categoryName == "Category0")
        XCTAssert(stats?.categories[0].expense == 123)
        XCTAssert(stats?.categories[0].averageExpense == 152.3)
        XCTAssert(stats?.categories[0].percentageExpense == 0.25)
        XCTAssert(stats?.categories[0].count == 3)
        XCTAssert(stats?.categories[0].averageCount == 5)
    }
    
    func testStatsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch stats")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockErrorStatsRemoteDataSource(),
                                             categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .stats(month: 4, year: 2022)
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
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .networkError)
    }
    
    // MARK: Historic
    func testHistoricSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch historic")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockSuccessStatsRemoteDataSource(),
                                             categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var historic: [Domain.MonthStats]?
        
        // When
        repository
            .historic(numberOfMonths: 4)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                historic = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(historic)
        XCTAssert(historic?.count == 3)
        XCTAssert(historic?[0].month == 1)
        XCTAssert(historic?[0].year == 2022)
        XCTAssert(historic?[0].expense == 123.23)
    }
    
    func testHistoricErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch historic")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockErrorStatsRemoteDataSource(),
                                             categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
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
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .networkError)
    }
}
