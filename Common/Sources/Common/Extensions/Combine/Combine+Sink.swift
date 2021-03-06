//
//  Combine+SinkCompletion.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation
import Combine

extension Publisher {
    
    public func sinkCompletion(completion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: completion, receiveValue: { _ in })
    }
    
    public func sinkReceiveValue(closure: @escaping ((Output) -> Void)) -> AnyCancellable {
        sink { _ in } receiveValue: { value in
            closure(value)
        }
    }
}
