//
//  Operation.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Domain

struct OperationDTO: Decodable {
}

extension OperationDTO {
    func toDomain() -> Domain.Operation {
        return Domain.Operation()
    }
}
