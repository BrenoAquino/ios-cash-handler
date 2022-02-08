//
//  DSDatePickerField.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import SwiftUI

public struct DSDatePickerField: View {
    
    let title: String
    @Binding var date: Date
    
    public init(title: String, date: Binding<Date>) {
        self.title = title
        self._date = date
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.caption1.rawValue)
            DatePicker("", selection: $date, displayedComponents: .date)
                .background(DSColor.clear.rawValue)
                .labelsHidden()
                .transformEffect(.init(scaleX: 0.7, y: 0.7))
        }
        .padding()
        .background(DSColor.secondBackground.rawValue)
        .clipShape(RoundedRectangle(cornerRadius: DSCornerRadius.normal.rawValue))
        .shadow(style: .easy)
    }
}

// MARK: - Preview
struct DSDatePickerField_Previews: PreviewProvider {
    static var previews: some View {
        DSDatePickerField(title: "Date", date: .constant(Date()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
