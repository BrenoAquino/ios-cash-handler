//
//  File.swift
//  
//
//  Created by Breno Aquino on 30/04/22.
//

import Foundation
import Combine

public typealias AnyDataPubliher<Output, Failure: Error> = AnyPublisher<DataResult<Output, Failure>?, Never>

public class DataPublisher<SuccessModel, FailureModel> where FailureModel: Error {
    
    enum RetrieveDataState {
        case empty
        case loading
        case availableData(update: Date)
    }
    
    public typealias Output = DataResult<SuccessModel, FailureModel>?
    public typealias Failure = Never
    
    // MARK: - Proprieties
    let cacheConfig: DataCacheConfig
    private var retreiveDataState: RetrieveDataState = .empty
    private var subject: CurrentValueSubject<Output, Failure>
    
    // MARK: - Inits
    public init(cacheRetrieveRule: DataCacheConfig.RetrieveRule, cacheTime: TimeInterval = .zero) {
        self.cacheConfig = .init(retrieveRule: cacheRetrieveRule, cacheTime: cacheTime)
        self.subject = .init(nil)
    }
}

// MARK: - Handle Values
extension DataPublisher {
    public func empty() {
        retreiveDataState = .empty
        subject.send(nil)
    }
    
    public func loading() {
        retreiveDataState = .loading
    }
    
    public func loaded(_ value: SuccessModel) {
        retreiveDataState = .availableData(update: .init())
        subject.send(.data(data: value))
    }
    
    public func error(_ error: FailureModel) {
        retreiveDataState = .empty
        subject.send(.error(error: error))
    }
    
    public func enableReload() -> Bool {
        switch retreiveDataState {
        case .availableData(let update):
            if cacheConfig.retrieveRule == .reloadIfLocalIsEmpty {
                return false
            }
            
            let deltaTime = TimeInterval(Date().timeIntervalSince(update))
            let isCacheExpired = deltaTime > cacheConfig.cacheTime
            
            if isCacheExpired && cacheConfig.retrieveRule == .firstReloadIfNeeded {
                retreiveDataState = .empty
                subject.send(nil)
            }
            
            return isCacheExpired
            
        case .loading:
            return false
            
        default:
            return true
        }
    }
}

// MARK: - Publisher
extension DataPublisher: Publisher {
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = DataSubscription<S, SuccessModel, FailureModel>(subscriber, requestPublisher: self.subject)
        subscriber.receive(subscription: subscription)   
    }
}
