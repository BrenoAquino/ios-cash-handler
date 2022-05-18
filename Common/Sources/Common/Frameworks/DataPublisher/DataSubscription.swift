//
//  B1Subscription.swift
//  
//
//  Created by Breno Aquino on 30/04/22.
//

import Foundation
import Combine

class DataSubscription<S: Subscriber, SuccessModel, FailureModel>: Subscription where S.Input == DataResult<SuccessModel, FailureModel>? {
    
    // MARK: - Props
    private var cancellable: AnyCancellable?
    private(set) var subscriber: S?
    private let requestPublisher: CurrentValueSubject<S.Input, Never>
    
    // MARK: - Inits
    init(_ subscriber: S, requestPublisher: CurrentValueSubject<S.Input, Never>) {
        self.subscriber = subscriber
        self.requestPublisher = requestPublisher
    }
}

// MARK: - Business Rule
extension DataSubscription {
    private func setupPublisher() {
        cancellable = requestPublisher
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .data(let data):
                    _ = self?.subscriber?.receive(.data(data: data))
                case .error(let error):
                    _ = self?.subscriber?.receive(.error(error: error))
                case .none:
                    break
                }
            })
    }
}

// MARK: - Subscription Cycle
extension DataSubscription {
    func cancel() {
        subscriber = nil
    }
    
    func request(_ demand: Subscribers.Demand) {
        setupPublisher()
    }
}
