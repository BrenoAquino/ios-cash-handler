//
//  OperationCell.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct OperationCell: View {
    
    let name: String
    
    var body: some View {
        Text(operation.title)
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        OperationCell(name: "Madero")
    }
}
