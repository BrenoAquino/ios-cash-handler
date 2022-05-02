//
//  File.swift
//  
//
//  Created by Breno Aquino on 30/04/22.
//

import Foundation
import Combine

enum DataState<Output> {
    case empty
    case loaded(data: Output, update: Date)
}

class DataPublisher<Output, Failure> where Failure: Error {
    
    // MARK: - Proprieties
    private let cacheTime: TimeInterval
    private var isLoading: Bool = false
    private var subject: CurrentValueSubject<DataState<Output>, Failure>
    
    // MARK: - Inits
    init(cacheTime: TimeInterval = .zero) {
        self.cacheTime = cacheTime
        self.subject = .init(.empty)
    }
}

// MARK: - Handle Values
extension DataPublisher {
    func empty() {
        isLoading = false
        subject.send(.empty)
    }
    
    func loading() {
        isLoading = true
    }
    
    func loaded(_ value: Output) {
        isLoading = false
        subject.send(.loaded(data: value, update: .init()))
    }
    
    func enableReload() -> Bool {
        if case .loaded(_, let update) = subject.value, cacheTime > .zero {
            let deltaTime = TimeInterval(Date().timeIntervalSince(update))
            let needRefresh = deltaTime > cacheTime
            if needRefresh { subject.send(.empty) }
            return needRefresh
        } else {
            return !isLoading
        }
    }
}

// MARK: - Publisher
extension DataPublisher: Publisher {
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = DataSubscription<S, Output, Failure>(subscriber, requestPublisher: self.subject)
        subscriber.receive(subscription: subscription)   
    }
}
