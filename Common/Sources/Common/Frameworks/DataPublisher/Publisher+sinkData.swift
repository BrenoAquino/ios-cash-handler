//
//  File.swift
//  
//
//  Created by Breno Aquino on 03/05/22.
//

import Combine

public extension Publisher {
    func sinkWithDataPublisher(_ dataPublisher: DataPublisher<Output, Failure>) -> AnyCancellable {
        return sink { completion in
            guard case .failure(let error) = completion else { return }
            dataPublisher.error(error)
        } receiveValue: { value in
            dataPublisher.loaded(value)
        }
    }
    
    func mapDataResult<SuccessModel, T>(_ transform: @escaping (SuccessModel) throws -> T) -> Publishers.TryMap<Self, T> where Output == Result<SuccessModel, Failure> {
        return tryMap { output in
            switch output {
            case .success(let success):
                return try transform(success)
            case .failure(let error):
                throw error
            }
        }
    }
}
