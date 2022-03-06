//
//  OperationsUseCasePreview.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
class OperationsUseCasePreview: OperationsUseCase {
    func categories() -> [Domain.Category] {
        return [
            Domain.Category(id: "0", name: "Lazer"),
            Domain.Category(id: "1", name: "Tecnologia")
        ]
    }
    
    func paymentMethods() -> [Domain.PaymentMethod] {
        return [
            Domain.PaymentMethod(id: "0", name: "Cartão de Crédito", hasInstallments: true),
            Domain.PaymentMethod(id: "1", name: "Transferência Bancária", hasInstallments: false)
        ]
    }
    
    func operations() -> AnyPublisher<[Domain.OperationsAggregator], CharlesError> {
        let march: Domain.OperationsAggregator = .init(month: 3, year: 2022, operations: [
            Domain.Operation(id: "0",
                             title: "Hollow Knight",
                             value: 13.99,
                             date: Date.components(day: 1, month: 3, year: 2022)!,
                             paymentMethod: .init(id: "0", name: "Cartão de Crédito", hasInstallments: true),
                             category: .init(id: "0", name: "Lazer")),
            Domain.Operation(id: "1",
                             title: "Monitor",
                             value: 1213.89,
                             date: Date.components(day: 20, month: 2, year: 2022)!,
                             paymentMethod: .init(id: "0", name: "Transferência Bancária", hasInstallments: false),
                             category: .init(id: "0", name: "Tecnologia"))
        ])
        
        return Just([march])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    func addOperation(title: String,
                      date: Date,
                      value: Double,
                      categoryId: String,
                      paymentMethodId: String,
                      installments: String) -> AnyPublisher<[Domain.Operation], CharlesError> {
        Empty().eraseToAnyPublisher()
    }
}
#endif
