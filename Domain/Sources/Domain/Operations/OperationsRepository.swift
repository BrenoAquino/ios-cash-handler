//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Common

public protocol OperationsRepository {
    func operations(month: Int?,
                    year: Int?,
                    categories: [Domain.Category],
                    paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError>
    func operations(startMonth: Int,
                    startYear: Int,
                    endMonth: Int,
                    endYear: Int,
                    categories: [Domain.Category],
                    paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError>
    func addOperation(createOperation: Domain.CreateOperation,
                      categories: [Domain.Category],
                      paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError>
    }
