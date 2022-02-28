//
//  OperationCell.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import DesignSystem

struct OperationCell: View {
    
    let operation: OperationUI
    
    var body: some View {
        HStack {
            Capsule()
                .frame(width: 1)
                .foregroundColor(Color.generate(by: operation.paymentMethodId))
            VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                Text(operation.title)
                    .font(DSFont.headline2.rawValue)
                Text(operation.subtitle)
                    .font(DSFont.subheadline.rawValue)
            }
            Spacer()
            Text(operation.value)
                .font(DSFont.headline2.rawValue)
                .foregroundColor(DSColor.discountValue.rawValue)
        }
        .padding(EdgeInsets(top: DSSpace.smallS.rawValue,
                            leading: DSSpace.smallM.rawValue,
                            bottom: DSSpace.smallS.rawValue,
                            trailing: DSSpace.smallM.rawValue))
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        OperationCell(operation: .init(id: .empty,
                                       title: "Madero",
                                       subtitle: "Refeição  •  20 / 12 / 2021",
                                       value: "R$ 112,54",
                                       paymentMethodId: ""))
            .frame(height: 50)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
