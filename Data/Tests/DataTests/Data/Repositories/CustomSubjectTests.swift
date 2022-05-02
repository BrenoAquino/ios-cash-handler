//
//  CustomSubjectTests.swift
//
//
//  Created by Breno Aquino on 30/04/22.
//

import XCTest
import Combine
import Domain

@testable import Data

class CustomPublisherSubscriptionTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = .init()
}
 
// MARK: - Publisher
extension CustomPublisherSubscriptionTests {
//    func testB1Alone() async {
//        // Given
//        let pub = DataPublisher<Int, Never>()
//        var sinks1: [Int] = []
//        var sinks2: [Int] = []
//        var sinks3: [Int] = []
//        var sinks4: [Int] = []
//        
//        // When
//        pub.loaded(0)
//        pub.sink(receiveValue: { sinks1.append($0) }).store(in: &cancellables)
//        pub.loading()
//        pub.loaded(1)
//        pub.sink(receiveValue: { sinks2.append($0) }).store(in: &cancellables)
//        pub.loaded(2)
//        pub.sink(receiveValue: { sinks3.append($0) }).store(in: &cancellables)
//        pub.empty()
//        pub.sink(receiveValue: { sinks4.append($0) }).store(in: &cancellables)
//        
//        // Then
//        XCTAssert(sinks1.count == 3)
//        XCTAssert(sinks1 == [0, 1, 2])
//        XCTAssert(sinks2.count == 2)
//        XCTAssert(sinks2 == [1, 2])
//        XCTAssert(sinks3.count == 1)
//        XCTAssert(sinks3 == [2])
//        XCTAssert(sinks4.count == 0)
//    }
}
 
// MARK: - Repository without Cachetime
extension CustomPublisherSubscriptionTests {
    func testDoubleLoadingZeroCachetime() {
        // Given
        let expectation = expectation(description: "double loading").numberOfTimesToCall(2)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sinks1.count == 1)
        XCTAssert(sinks1 == [["0", "1", "2"]])
        XCTAssert(sinks2.count == 1)
        XCTAssert(sinks2 == [["0", "1", "2"]])
    }
    
    func testNewRequestAfeterOneZeroCachetime() {
        // Given
        let expectation = expectation(description: "sequential request").numberOfTimesToCall(4)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks2.append(categoriesIds)
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 5)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 3)
        XCTAssert(sinks1.count == 2)
        XCTAssert(sinks1 == [["0", "1", "2"], ["3", "4", "5"]])
        XCTAssert(sinks2.count == 2)
        XCTAssert(sinks2 == [["0", "1", "2"], ["3", "4", "5"]])
    }
    
    func testDoubleRequestAndNewRequestZeroCachetime() {
        // Given
        let expectation = expectation(description: "double loading with sequential request").numberOfTimesToCall(11)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        var sinks3: [[String]] = []
        var sinks4: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill() // 1 4 8
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
                expectation.fulfill() // 2 5 9
            }
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks3.append(categoriesIds)
                    expectation.fulfill() // 3 6 10
                }
                .store(in: &self.cancellables)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks4.append(categoriesIds)
                    expectation.fulfill() // 7 11
                }
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 10)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sinks1.count == 3)
        XCTAssert(sinks1 == [["0", "1", "2"], ["3", "4", "5"], ["6", "7", "8"]])
        XCTAssert(sinks2.count == 3)
        XCTAssert(sinks2 == [["0", "1", "2"], ["3", "4", "5"], ["6", "7", "8"]])
        XCTAssert(sinks3.count == 3)
        XCTAssert(sinks3 == [["0", "1", "2"], ["3", "4", "5"], ["6", "7", "8"]])
        XCTAssert(sinks4.count == 2)
        XCTAssert(sinks4 == [["3", "4", "5"], ["6", "7", "8"]])
    }
}
 
// MARK: - Repository with Cachetime
extension CustomPublisherSubscriptionTests {
    func testDoubleLoading() {
        // Given
        let expectation = expectation(description: "double loading with cachetime").numberOfTimesToCall(2)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: 2)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sinks1.count == 1)
        XCTAssert(sinks1 == [["0", "1", "2"]])
        XCTAssert(sinks2.count == 1)
        XCTAssert(sinks2 == [["0", "1", "2"]])
    }
    
    func testNewRequestAfeterOne() {
        // Given
        let expectation = expectation(description: "sequential requests with cachetime").numberOfTimesToCall(2)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: 2)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks2.append(categoriesIds)
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 5)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 2)
        XCTAssert(sinks1.count == 1)
        XCTAssert(sinks1 == [["0", "1", "2"]])
        XCTAssert(sinks2.count == 1)
        XCTAssert(sinks2 == [["0", "1", "2"]])
    }
    
    func testDoubleRequestAndNewRequest() {
        // Given
        let expectation = expectation(description: "double loading with sequential request").numberOfTimesToCall(7)
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: 2)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        var sinks3: [[String]] = []
        var sinks4: [[String]] = []
        let startTime = Date()
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks3.append(categoriesIds)
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            repository
                .fetchCategories()
                .map { $0.map { $0.id } }
                .sinkReceiveValue { categoriesIds in
                    sinks4.append(categoriesIds)
                    expectation.fulfill()
                }
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 7)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sinks1.count == 2)
        XCTAssert(sinks1 == [["0", "1", "2"], ["3", "4", "5"]])
        XCTAssert(sinks2.count == 2)
        XCTAssert(sinks2 == [["0", "1", "2"], ["3", "4", "5"]])
        XCTAssert(sinks3.count == 2)
        XCTAssert(sinks3 == [["0", "1", "2"], ["3", "4", "5"]])
        XCTAssert(sinks4.count == 1)
        XCTAssert(sinks4 == [["3", "4", "5"]])
    }
}
