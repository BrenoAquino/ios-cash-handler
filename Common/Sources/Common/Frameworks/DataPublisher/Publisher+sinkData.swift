//
//  File.swift
//  
//
//  Created by Breno Aquino on 03/05/22.
//

import Combine
import Foundation

public extension Publisher {
    func sinkWithDataPublisher(_ dataPublisher: DataPublisher<Output, Failure>) -> AnyCancellable {
        return sink { completion in
            guard case .failure(let error) = completion else { return }
            dataPublisher.error(error)
        } receiveValue: { value in
            dataPublisher.loaded(value)
        }
    }
    
    func mapDataResult<SuccessType, FailureType, T>(_ transform: @escaping (SuccessType) -> T) -> Publishers.Map<Self, DataResult<T, FailureType>>
    where FailureType: Error, Output == DataResult<SuccessType, FailureType>, Failure == Never {
        return map { $0.mapData { transform($0) } }
    }
    
    func mapErrorResult<SuccessType, FailureType, T>(_ transform: @escaping (FailureType) -> T) -> Publishers.Map<Self, DataResult<SuccessType, T>>
    where FailureType: Error, Output == DataResult<SuccessType, FailureType>, Failure == Never {
        return map { $0.mapError { transform($0) } }
    }
    
    func tryMapData<SuccessType, FailureType, T>(_ transform: @escaping (SuccessType) -> T) -> Publishers.TryMap<Self, T>
    where FailureType: Error, Output == DataResult<SuccessType, FailureType> {
        return tryMap { element in
            guard case .data(let data) = element else {
                throw NSError() // FIXME: create error for this flow
            }
            return transform(data)
        }
    }
}
