//
//  DataPublisherTests.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import XCTest
import Combine

@testable import Common

class DataPublisherTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = .init()
    
    private func fakeRequest<Output, Failure>(_ publisher: DataPublisher<Output, Failure>,
                                              delay: TimeInterval,
                                              possibleValue: Output) -> AnyDataPubliher<Output, Failure> {
        defer {
            if publisher.enableReload() {
                publisher.loading()
                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                    publisher.loaded(possibleValue)
                }
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    private func fakeRequestError<Output, Failure>(_ publisher: DataPublisher<Output, Failure>,
                                                   delay: TimeInterval,
                                                   possibleValue: Output) -> AnyDataPubliher<Output, Failure> {
        defer {
            if publisher.enableReload() {
                publisher.loading()
                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                    publisher.loaded(possibleValue)
                }
            }
        }
        return publisher.eraseToAnyPublisher()
    }
}

// MARK: - Config: Cachetime(zero) and FirstDataAfterReloadIfNeeded
extension DataPublisherTests {
    func testDuplicatedZeroCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialZeroCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(4)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 3)
        XCTAssert(sink1 == [0, 1])
        XCTAssert(sink2 == [0, 1])
    }
    
    func testDuplicatedSequentialZeroCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(6)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 3)
        XCTAssert(sink1 == [0, 2])
        XCTAssert(sink2 == [0, 2])
        XCTAssert(sink3 == [0, 2])
    }
}

// MARK: - Config: Cachetime(zero) and FirstReloadIfNeeded
extension DataPublisherTests {
    func testDuplicatedZeroCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialZeroCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(3)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 3)
        XCTAssert(sink1 == [0, 1])
        XCTAssert(sink2 == [1])
    }
    
    func testDuplicatedSequentialZeroCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(5)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: .zero)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 3)
        XCTAssert(sink1 == [0, 2])
        XCTAssert(sink2 == [0, 2])
        XCTAssert(sink3 == [2])
    }
}

// MARK: - Config: Cachetime(1) and FirstDataAfterReloadIfNeeded
extension DataPublisherTests {
    func testDuplicatedOneCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: 1)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialOneCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 2)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialExpiredCacheOneCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(4)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 7)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sink1 == [0, 1])
        XCTAssert(sink2 == [0, 1])
    }
    
    func testDuplicatedSequentialOneCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(3)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 3)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 2)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
        XCTAssert(sink3 == [0])
    }
    
    func testDuplicatedSequentialExpiredCacheOneCachetimeAndFirstDataAfterReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(6)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstDataAfterReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 7)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sink1 == [0, 2])
        XCTAssert(sink2 == [0, 2])
        XCTAssert(sink3 == [0, 2])
    }
}

// MARK: - Config: Cachetime(1) and FirstReloadIfNeeded
extension DataPublisherTests {
    func testDuplicatedOneCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 1)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 1)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialOneCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(2)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 4)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 2)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
    }
    
    func testSequentialExpiredCacheOneCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "sequential").numberOfTimesToCall(3)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 1)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink2.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 7)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sink1 == [0, 1])
        XCTAssert(sink2 == [1])
    }
    
    func testDuplicatedSequentialOneCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(3)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 3)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 2)
        XCTAssert(sink1 == [0])
        XCTAssert(sink2 == [0])
        XCTAssert(sink3 == [0])
    }
    
    func testDuplicatedSequentialExpiredCacheOneCachetimeAndFirstReloadIfNeeded() {
        // Given
        let expectation = expectation(description: "duplicated sequential").numberOfTimesToCall(5)
        let publisher = DataPublisher<Int, Never>(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 2)
        var sink1: [Int] = []
        var sink2: [Int] = []
        var sink3: [Int] = []
        let startTime = Date()
        
        // When
        fakeRequest(publisher, delay: 1, possibleValue: 0)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink1.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        fakeRequest(publisher, delay: 1, possibleValue: 1)
            .sink(receiveValue: { result in
                switch result {
                case .data(let data):
                    sink2.append(data)
                default:
                    XCTFail("Must be success")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
            self.fakeRequest(publisher, delay: 1, possibleValue: 2)
                .sink(receiveValue: { result in
                    switch result {
                    case .data(let data):
                        sink3.append(data)
                    default:
                        XCTFail("Must be success")
                    }
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
        }
        
        // Then
        waitForExpectations(timeout: 7)
        let seconds = Int(Date().timeIntervalSince(startTime))
        XCTAssert(seconds == 5)
        XCTAssert(sink1 == [0, 2])
        XCTAssert(sink2 == [0, 2])
        XCTAssert(sink3 == [2])
    }
}

// MARK: - Error behavior
extension DataPublisherTests {
    func testReceiveError() {}
    
    func testReceiveErrorAndTryAnotherRequest() {}
    
    func testReceiveErrorAndReceiveSuccess() {}
}
