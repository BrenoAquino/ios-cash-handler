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
    
    func testB1Alone() async {
        // Given
        let pub = DataPublisher<Int, Never>()
        var sinks1: [Int] = []
        var sinks2: [Int] = []
        var sinks3: [Int] = []
        var sinks4: [Int] = []
        
        // When
        pub.loaded(0)
        pub.sink(receiveValue: { sinks1.append($0) }).store(in: &cancellables)
        pub.loading()
        pub.loaded(1)
        pub.sink(receiveValue: { sinks2.append($0) }).store(in: &cancellables)
        pub.loaded(2)
        pub.sink(receiveValue: { sinks3.append($0) }).store(in: &cancellables)
        pub.empty()
        pub.sink(receiveValue: { sinks4.append($0) }).store(in: &cancellables)
        
        // Then
        XCTAssert(sinks1.count == 3)
        XCTAssert(sinks1 == [0, 1, 2])
        XCTAssert(sinks2.count == 2)
        XCTAssert(sinks2 == [1, 2])
        XCTAssert(sinks3.count == 1)
        XCTAssert(sinks3 == [2])
        XCTAssert(sinks4.count == 0)
    }
    
    func testDoubleLoading() async {
        // Given
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 0.5)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        // Then
        try! await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        XCTAssert(sinks1.count == 1)
        XCTAssert(sinks1 == [["0", "1", "2"]])
        XCTAssert(sinks2.count == 1)
        XCTAssert(sinks2 == [["0", "1", "2"]])
    }
    
    func testNewRequestAfeterOne() async {
        // Given
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 1)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        try! await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        // Then
        try! await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        XCTAssert(sinks1.count == 2)
        XCTAssert(sinks1 == [["0", "1", "2"], ["3", "4", "5"]])
        XCTAssert(sinks2.count == 2)
        XCTAssert(sinks2 == [["0", "1", "2"], ["3", "4", "5"]])
    }
    
    func testDoubleRequestAndNewRequest() async {
        // Given
        let remoteDataSource = MockDelayCategoriesRemoteDataSource(responseDelay: 0.5)
        let repository = ChlsCategoriesRepository(remoteDataSource: remoteDataSource, cacheTime: .zero)
        var sinks1: [[String]] = []
        var sinks2: [[String]] = []
        var sinks3: [[String]] = []
        var sinks4: [[String]] = []
        
        // When
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks1.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks2.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        try! await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks3.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        try! await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
        
        repository
            .fetchCategories()
            .map { $0.map { $0.id } }
            .sinkReceiveValue { categoriesIds in
                sinks4.append(categoriesIds)
            }
            .store(in: &cancellables)
        
        // Then
        try! await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
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
