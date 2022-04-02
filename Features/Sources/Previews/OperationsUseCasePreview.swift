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
    ]
    
    public init() {}
    
    public func monthOverview(month: Int, year: Int) -> AnyPublisher<MonthOverview, CharlesError> {
        return Just(Domain.MonthOverview(month: month, year: year, expense: 1234.7, categoriesOverviews: []))
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func aggregateOperations() -> AnyPublisher<[Domain.OperationsAggregator], CharlesError> {
        let march: Domain.OperationsAggregator = .init(month: 3, year: 2022, operations: operations)
        return Just([march])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func addOperation(title: String,
                      date: Date,
                      value: Double,
                      categoryId: String,
                      paymentMethodId: String,
                      installments: String) -> AnyPublisher<[Domain.Operation], CharlesError> {
        Empty().eraseToAnyPublisher()
    }
}
#endif
