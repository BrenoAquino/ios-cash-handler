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
    var categories: [Domain.Category] {
        return [
            .init(id: "521bac2c00686155bc874aac9c83650c2201140d13c14db953251b635bcc25cb", name: "Tech")
        ]
    }
    
    // MARK: Stats
    func testStatsSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch stats")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockSuccessStatsRemoteDataSource())
        var stats: Domain.Stats?
        
        // When
        repository
            .stats(month: 4, year: 2022, categories: categories)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                stats = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        let formatter = DateFormatter(pattern: "yyyy-MM")
        XCTAssertNotNil(stats)
        XCTAssertEqual(formatter.string(from: stats!.month), "2022-04")
        XCTAssertEqual(stats?.expense, 234.23)
        XCTAssertEqual(stats?.categories.count, 2)
        XCTAssertEqual(stats?.categories[0].categoryId, "0")
        XCTAssertEqual(stats?.categories[0].categoryName, "Category0")
        XCTAssertEqual(stats?.categories[0].expense, 123)
        XCTAssertEqual(stats?.categories[0].averageExpense, 152.3)
        XCTAssertEqual(stats?.categories[0].percentageExpense, 0.25)
        XCTAssertEqual(stats?.categories[0].count, 3)
        XCTAssertEqual(stats?.categories[0].averageCount, 5)
        XCTAssertEqual(stats?.categories[0].percentageCount, 5)
    }
    
    func testStatsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch stats")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockErrorStatsRemoteDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .stats(month: 4, year: 2022, categories: categories)
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
        XCTAssertEqual(error?.type, .networkError)
    }
    
    // MARK: Historic
    func testHistoricSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch historic")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockSuccessStatsRemoteDataSource())
        var historic: [Domain.MonthStats]?
        
        // When
        repository
            .historic(startDate: .empty, endDate: .empty)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                historic = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        let formatter = DateFormatter(pattern: "yyyy-MM")
        XCTAssertNotNil(historic)
        XCTAssertEqual(historic?.count, 3)
        XCTAssertEqual(formatter.string(from: historic![0].month), "2022-01")
        XCTAssertEqual(historic?[0].expense, 123.23)
    }
    
    func testHistoricErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch historic")
        let repository = StatsRepositoryImpl(statsRemoteDataSource: MockErrorStatsRemoteDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .historic(startDate: .empty, endDate: .empty)
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
