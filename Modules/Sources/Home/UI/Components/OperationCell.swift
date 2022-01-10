//
//  OperationCell.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Core

struct OperationCell: View {
    
    let operation: Core.Operation
    
    var body: some View {
        Text(operation.title)
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        let operation = Core.Operation(id: "", title: "Madero")
        OperationCell(operation: operation)
    }
}
