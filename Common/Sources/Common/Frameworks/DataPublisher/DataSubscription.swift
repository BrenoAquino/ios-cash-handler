//
//  B1Subscription.swift
//  
//
//  Created by Breno Aquino on 30/04/22.
//

import Foundation
import Combine

class DataSubscription<S: Subscriber, Output, Failure>: Subscription where S.Input == Output, Failure: Error {
    
    // MARK: - Props
    private var cancellable: AnyCancellable?
    private(set) var subscriber: S?
    private let requestPublisher: CurrentValueSubject<DataState<Output>, Failure>
    
    // MARK: - Inits
    init(_ subscriber: S, requestPublisher: CurrentValueSubject<DataState<Output>, Failure>) {
        self.subscriber = subscriber
        self.requestPublisher = requestPublisher
    }
}

// MARK: - Business Rule
extension DataSubscription {
    private func setupPublisher() {
        cancellable?.cancel()
        cancellable = requestPublisher
            .sink { [weak self] completion in
                self?.subscriber?.receive(completion: .finished)
            } receiveValue: { [weak self] model in
                guard case .loaded(let date, _) = model else { return }
                _ = self?.subscriber?.receive(date)
            }
    }
}

// MARK: - Subscription Cycle
extension DataSubscription {
    func cancel() {
        subscriber = nil
    }
    
    func request(_ demand: Subscribers.Demand) {
        self.setupPublisher()
    }
}
