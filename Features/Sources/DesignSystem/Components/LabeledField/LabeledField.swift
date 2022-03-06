//
//  LabeledField.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct LabeledField<Content>: View where Content : View {
    
    private let title: String
    @ViewBuilder private let content: () -> Content
    
    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(DSFont.headline3.rawValue)
                .foregroundColor(DSColor.placholder.rawValue)
                .padding(.leading, DSSpace.smallL.rawValue)

            HStack {
                content()
                Spacer()
            }
            .frame(minHeight: DSLabeledField.minHeight, alignment: .leading)
            .padding(.horizontal, DSSpace.smallL.rawValue)
            .padding(.vertical, DSSpace.smallM.rawValue)
            .background(DSColor.secondBackground.rawValue)
            .cornerRadius(DSCornerRadius.normal.rawValue)
        }
    }
}
