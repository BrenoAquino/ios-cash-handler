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
        Group {
            HStack {
                Capsule()
                    .frame(width: 1)
                    .foregroundColor(Color.generate(by: operation.paymentMethodId))
                
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    HStack {
                        Text(operation.title)
                            .font(DSFont.headline2.rawValue)
                            .foregroundColor(DSColor.primaryText.rawValue)
                        
                        if let valueDescription = operation.valueDescription {
                            Text(valueDescription)
                                .font(DSFont.footnote.rawValue)
                                .foregroundColor(DSColor.primaryText.rawValue)
                        }
                    }
                    
                    
                    Text(operation.subtitle)
                        .font(DSFont.subheadline.rawValue)
                        .foregroundColor(DSColor.primaryText.rawValue)
                }
                
                Spacer()
                
                Text(operation.value)
                    .font(DSFont.headline2.rawValue)
                    .foregroundColor(DSColor.discountValue.rawValue)
                
            }
            .padding(EdgeInsets(top: DSSpace.smallM.rawValue,
                                leading: DSSpace.smallM.rawValue,
                                bottom: DSSpace.smallM.rawValue,
                                trailing: DSSpace.smallM.rawValue))
        }
        .background(DSColor.secondBackground.rawValue)
        .cornerRadius(DSCornerRadius.normal.rawValue)
        .shadow(style: .easy)
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        OperationCell(operation: .init(id: .empty,
                                       title: "The Legend of Zelda",
                                       subtitle: "Refeição  •  20 / 12 / 2021",
                                       value: "R$ 112,54",
                                       paymentMethodId: "",
                                       valueDescription: "1 / 2"))
            .frame(height: 50)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        
        OperationCell(operation: .init(id: .empty,
                                       title: "The Legend of Zelda",
                                       subtitle: "Refeição  •  20 / 12 / 2021",
                                       value: "R$ 112,54",
                                       paymentMethodId: "",
                                       valueDescription: nil))
            .frame(height: 50)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
