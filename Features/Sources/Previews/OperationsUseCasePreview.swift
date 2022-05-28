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
public class OperationsUseCasePreview: OperationsUseCase {
    private let operations: [Domain.Operation] = [
        Domain.Operation(id: "0",
                         name: "Hollow Knight",
                         value: 13.99,
                         date: Date.components(day: 1, month: 3, year: 2022)!,
                         paymentMethod: .init(id: "0", name: "Cartão de Crédito", hasInstallments: true),
                         category: .init(id: "0", name: "Lazer")),
        Domain.Operation(id: "1",
                         name: "Monitor",
                         value: 1213.89,
                         date: Date.components(day: 20, month: 2, year: 2022)!,
                         paymentMethod: .init(id: "0", name: "Transferência Bancária", hasInstallments: false),
                         category: .init(id: "0", name: "Tecnologia"))
    ]
    
    public init() {}
    
    public func monthOverview(month: Int, year: Int) -> AnyPublisher<MonthStats, CharlesError> {
        return Just(Domain.MonthStats(month: Date.components(day: 1, month: month, year: year)!,
                                      expense: 1234.7))
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func aggregateOperations() -> AnyPublisher<[Domain.OperationsAggregator], CharlesError> {
        let march: Domain.OperationsAggregator = .init(month: 3, year: 2022, operations: operations)
        return Just([march])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func addOperation(name: String,
                             date: Date,
                             value: Double,
                             categoryId: String,
                             paymentMethodId: String,
                             installments: String) -> AnyPublisher<[Domain.Operation], CharlesError> {
        Empty().eraseToAnyPublisher()
    }
}
#endif
